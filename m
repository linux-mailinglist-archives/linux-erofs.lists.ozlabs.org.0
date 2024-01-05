Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F08824DAD
	for <lists+linux-erofs@lfdr.de>; Fri,  5 Jan 2024 05:44:17 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4T5rT915Jbz3c1g
	for <lists+linux-erofs@lfdr.de>; Fri,  5 Jan 2024 15:44:13 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4T5rT04K3Pz2yLr
	for <linux-erofs@lists.ozlabs.org>; Fri,  5 Jan 2024 15:44:02 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R881e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=49;SR=0;TI=SMTPD_---0VzzUQHt_1704429833;
Received: from 30.222.33.160(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VzzUQHt_1704429833)
          by smtp.aliyun-inc.com;
          Fri, 05 Jan 2024 12:43:56 +0800
Message-ID: <a2c7910c-4c2f-4290-a895-1c4255b2ee62@linux.alibaba.com>
Date: Fri, 5 Jan 2024 12:43:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 for-6.8/block 11/17] erofs: use bdev api
To: Yu Kuai <yukuai1@huaweicloud.com>, Jan Kara <jack@suse.cz>
References: <20231221085712.1766333-1-yukuai1@huaweicloud.com>
 <20231221085826.1768395-1-yukuai1@huaweicloud.com>
 <20240104120207.ig7tfc3mgckwkp2n@quack3>
 <7f868579-f993-aaa1-b7d7-eccbe0b0173c@huaweicloud.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <7f868579-f993-aaa1-b7d7-eccbe0b0173c@huaweicloud.com>
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
Cc: hoeppner@linux.ibm.com, vigneshr@ti.com, yi.zhang@huawei.com, clm@fb.com, adilger.kernel@dilger.ca, miquel.raynal@bootlin.com, agordeev@linux.ibm.com, linux-s390@vger.kernel.org, linux-nilfs@vger.kernel.org, linux-scsi@vger.kernel.org, richard@nod.at, willy@infradead.org, linux-bcachefs@vger.kernel.org, xen-devel@lists.xenproject.org, linux-ext4@vger.kernel.org, jejb@linux.ibm.com, p.raghav@samsung.com, gor@linux.ibm.com, hca@linux.ibm.com, joern@lazybastard.org, josef@toxicpanda.com, colyli@suse.de, linux-block@vger.kernel.org, linux-bcache@vger.kernel.org, viro@zeniv.linux.org.uk, "yukuai \(C\)" <yukuai3@huawei.com>, dsterba@suse.com, konishi.ryusuke@gmail.com, axboe@kernel.dk, brauner@kernel.org, tytso@mit.edu, martin.petersen@oracle.com, nico@fluxnic.net, yangerkun@huawei.com, linux-kernel@vger.kernel.org, kent.overstreet@gmail.com, hare@suse.de, jack@suse.com, linux-fsdevel@vger.kernel.org, linux-mtd@lists.infradead.org, akpm@linux-foundation.org, roger.pau@citrix.com, linux
 -erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org, sth@linux.ibm.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/1/4 20:32, Yu Kuai wrote:
> Hi, Jan!
> 
> 在 2024/01/04 20:02, Jan Kara 写道:
>> On Thu 21-12-23 16:58:26, Yu Kuai wrote:
>>> From: Yu Kuai <yukuai3@huawei.com>
>>>
>>> Avoid to access bd_inode directly, prepare to remove bd_inode from
>>> block_device.
>>>
>>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>>
>> I'm not erofs maintainer but IMO this is quite ugly and grows erofs_buf
>> unnecessarily. I'd rather store 'sb' pointer in erofs_buf and then do the
>> right thing in erofs_bread() which is the only place that seems to care
>> about the erofs_is_fscache_mode() distinction... Also blkszbits is then
>> trivially sb->s_blocksize_bits so it would all seem much more
>> straightforward.
> 
> Thanks for your suggestion, I'll follow this unless Gao Xiang has other
> suggestions.

Yes, that would be better, I'm fine with that.  Yet in the future we
may support a seperate large dirblocksize more than block size, but
we could revisit later.

Thanks,
Gao Xiang

> 
> Kuai
>>
>>                                 Honza
>>
