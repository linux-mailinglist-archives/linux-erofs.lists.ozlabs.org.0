Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9181074A08A
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Jul 2023 17:12:56 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Qxg523WSFz3bsw
	for <lists+linux-erofs@lfdr.de>; Fri,  7 Jul 2023 01:12:54 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Qxg4v0jnBz3bsw
	for <linux-erofs@lists.ozlabs.org>; Fri,  7 Jul 2023 01:12:45 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R411e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0Vml4Kei_1688656357;
Received: from 192.168.3.2(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vml4Kei_1688656357)
          by smtp.aliyun-inc.com;
          Thu, 06 Jul 2023 23:12:39 +0800
Message-ID: <4949c20e-177f-7952-7870-41f3b3fd791f@linux.alibaba.com>
Date: Thu, 6 Jul 2023 23:12:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2 39/92] erofs: convert to ctime accessor functions
To: Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
 <20230705190309.579783-37-jlayton@kernel.org>
 <20230706110007.dc4tpyt5e6wxi5pt@quack3>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230706110007.dc4tpyt5e6wxi5pt@quack3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
Cc: Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, Yue Hu <huyue2@coolpad.com>, Al Viro <viro@zeniv.linux.org.uk>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Jan,

On 2023/7/6 19:00, Jan Kara wrote:
> On Wed 05-07-23 15:01:04, Jeff Layton wrote:
>> In later patches, we're going to change how the inode's ctime field is
>> used. Switch to using accessor functions instead of raw accesses of
>> inode->i_ctime.
>>
>> Acked-by: Gao Xiang <xiang@kernel.org>
>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> 
> Just one nit below:
> 
>> @@ -176,10 +175,10 @@ static void *erofs_read_inode(struct erofs_buf *buf,
>>   		vi->chunkbits = sb->s_blocksize_bits +
>>   			(vi->chunkformat & EROFS_CHUNK_FORMAT_BLKBITS_MASK);
>>   	}
>> -	inode->i_mtime.tv_sec = inode->i_ctime.tv_sec;
>> -	inode->i_atime.tv_sec = inode->i_ctime.tv_sec;
>> -	inode->i_mtime.tv_nsec = inode->i_ctime.tv_nsec;
>> -	inode->i_atime.tv_nsec = inode->i_ctime.tv_nsec;
>> +	inode->i_mtime.tv_sec = inode_get_ctime(inode).tv_sec;
>> +	inode->i_atime.tv_sec = inode_get_ctime(inode).tv_sec;
>> +	inode->i_mtime.tv_nsec = inode_get_ctime(inode).tv_nsec;
>> +	inode->i_atime.tv_nsec = inode_get_ctime(inode).tv_nsec;
> 
> Isn't this just longer way to write:
> 
> 	inode->i_atime = inode->i_mtime = inode_get_ctime(inode);

I'm fine with this.  I think we could use this (although I'm not sure
if checkpatch will complain but personally I'm fine.)

Thanks,
Gao Xiang

> 
> ?
> 
> 								Honza
