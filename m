Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D03C6B34F1
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Mar 2023 04:47:52 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PXsT21sZQz3cdK
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Mar 2023 14:47:50 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PXsSx1w0jz3bgy
	for <linux-erofs@lists.ozlabs.org>; Fri, 10 Mar 2023 14:47:44 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0VdVeWEX_1678420058;
Received: from 30.97.48.46(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VdVeWEX_1678420058)
          by smtp.aliyun-inc.com;
          Fri, 10 Mar 2023 11:47:39 +0800
Message-ID: <24a46ae8-6e50-2f45-f099-45743bb013c4@linux.alibaba.com>
Date: Fri, 10 Mar 2023 11:47:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v3 2/6] erofs: convert to use i_blockmask()
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Al Viro <viro@zeniv.linux.org.uk>, Yangtao Li <frank.li@vivo.com>
References: <20230309152127.41427-1-frank.li@vivo.com>
 <20230309152127.41427-2-frank.li@vivo.com> <20230310031547.GD3390869@ZenIV>
 <2fa31829-03f0-7bfb-a89b-e3917c479733@linux.alibaba.com>
In-Reply-To: <2fa31829-03f0-7bfb-a89b-e3917c479733@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: brauner@kernel.org, tytso@mit.edu, agruenba@redhat.com, joseph.qi@linux.alibaba.com, mark@fasheh.com, linux-kernel@vger.kernel.org, cluster-devel@redhat.com, rpeterso@redhat.com, huyue2@coolpad.com, adilger.kernel@dilger.ca, jlbec@evilplan.org, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org, ocfs2-devel@oss.oracle.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/3/10 11:42, Gao Xiang wrote:
> Hi Al,
> 
> On 2023/3/10 11:15, Al Viro wrote:
>> On Thu, Mar 09, 2023 at 11:21:23PM +0800, Yangtao Li wrote:
>>> Use i_blockmask() to simplify code.
>>
>> Umm...  What's the branchpoint for that series?  Not the mainline -
>> there we have i_blocksize() open-coded...
> 
> Actually Yue Hu sent out a clean-up patch and I applied to -next for
> almost a week and will be upstreamed for 6.3-rc2:
> 
> https://lore.kernel.org/r/a238dca1-256f-ae2f-4a33-e54861fe4ffb@kernel.org/T/#t

Sorry this link:
https://lore.kernel.org/r/0261de31-e98b-85cd-80de-96af5a76e15c@linux.alibaba.com

Yangtao's suggestion was to use GENMASK, and I'm not sure it's a good way
since (i_blocksize(inode) - 1) is simple enough, and then it becomes like
this.

Thanks,
Gao Xiang


> 
> And then Yangtao would like to wrap this as a new VFS helper, I'm not
> sure why it's necessary since it doesn't save a lot but anyway, I'm open
> to it if VFS could have such new helper.
> 
> Thanks,
> Gao Xiang
> 
>>
>>> Signed-off-by: Yangtao Li <frank.li@vivo.com>
>>> ---
>>> v3:
>>> -none
>>> v2:
>>> -convert to i_blockmask()
>>>   fs/erofs/data.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
>>> index 7e8baf56faa5..e9d1869cd4b3 100644
>>> --- a/fs/erofs/data.c
>>> +++ b/fs/erofs/data.c
>>> @@ -380,7 +380,7 @@ static ssize_t erofs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>>>           if (bdev)
>>>               blksize_mask = bdev_logical_block_size(bdev) - 1;
>>>           else
>>> -            blksize_mask = i_blocksize(inode) - 1;
>>> +            blksize_mask = i_blockmask(inode);
>>>           if ((iocb->ki_pos | iov_iter_count(to) |
>>>                iov_iter_alignment(to)) & blksize_mask)
>>> -- 
>>> 2.25.1
>>>
