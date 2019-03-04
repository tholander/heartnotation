import React, { Component, useState } from 'react';
import { Drawer, Button, Icon } from 'antd';
import CommentChatAnnotation from '../chatAnnotation/CommentChatAnnotation';

interface Props {
  annotation_id: number;
}
const MessageSvg = () => (
  <svg
    viewBox='0 0 946.68 736'
    width='30px'
    height='20px'
    fill='currentColor'
    transform='translate(0 2)'
  >
    <path
      d='M853.9,556.1V630a8,8,0,0,1-13,6.3l-141.7-112a8,8,0,0,1,0-12.6L841,399.7a8,8,0,0,1,12.9,6.3v74.1'
      transform='translate(-33.42 -150)'
    />
    <rect x='870.68' width='76' height='736' rx='8' />
    <circle cx='360.34' cy='368' r='38.61' />
    <circle
      cx='232.89'
      cy='518'
      r='38.61'
      transform='translate(-368.22 384.94) rotate(-67.5)'
    />
    <circle
      cx='554.62'
      cy='518'
      r='38.61'
      transform='translate(-169.61 682.17) rotate(-67.5)'
    />
    <path
      d='M745,437.2s-1.26-5.36-1.94-8A359.87,359.87,0,0,0,393.76,157.66h-1.61A360.49,360.49,0,0,0,72,680.47V802.73a37,37,0,0,0,37,37H231.37a361.53,361.53,0,0,0,160.78,38.61h1.69a359.78,359.78,0,0,0,346.8-262c.57-2,4.61-18.21,4.61-18.21l-54.59-41.62c-6,46.42-25.57,88.4-25.57,88.4a298.38,298.38,0,0,1-60.52,85.79h0c-56.38,55.82-131.18,86.55-210.81,86.55h-1.37a300.29,300.29,0,0,1-139.23-35l-6.75-3.62H133.16V665.35l-3.62-6.75a300.29,300.29,0,0,1-35-139.23c-.32-80.19,30.32-155.48,86.55-212.18s131.18-88.08,211.37-88.4h1.37a299,299,0,0,1,293,237.56c1.64,7.84,4,23.72,4,23.72h0m51.51-32.86-42.58,76.32'
      transform='translate(-33.42 -150)'
    />
  </svg>
);

export default (props: Props) => {
  const { annotation_id } = props;
  const [visible, setVisible] = useState(false);
  return (
    <div className='chat-drawer-container'>
      <Button
        type='primary'
        size='large'
        onClick={() => setVisible(true)}
        className='btn-space'
      >
        <Icon component={MessageSvg} />
        Comments
      </Button>
      <Drawer
        title='Annotation Comments'
        placement='right'
        width='512'
        closable={false}
        onClose={() => setVisible(false)}
        visible={visible}
      >
        <CommentChatAnnotation annotation_id={annotation_id} />
      </Drawer>
    </div>
  );
};
