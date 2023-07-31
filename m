Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DCBE7693D7
	for <lists+linux-erofs@lfdr.de>; Mon, 31 Jul 2023 12:58:33 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RDwFz2YpWz2ytT
	for <lists+linux-erofs@lfdr.de>; Mon, 31 Jul 2023 20:58:31 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RDwFr0z2nz2y1d
	for <linux-erofs@lists.ozlabs.org>; Mon, 31 Jul 2023 20:58:22 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0Voe5MEo_1690801095;
Received: from 10.120.130.14(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Voe5MEo_1690801095)
          by smtp.aliyun-inc.com;
          Mon, 31 Jul 2023 18:58:17 +0800
Message-ID: <9b57e5f7-62b6-fd65-4dac-a71c9dc08abc@linux.alibaba.com>
Date: Mon, 31 Jul 2023 18:58:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [syzbot] [erofs?] [fat?] WARNING in erofs_kill_sb
To: Christoph Hellwig <hch@lst.de>,
 syzbot <syzbot+69c477e882e44ce41ad9@syzkaller.appspotmail.com>
References: <000000000000f43cab0601c3c902@google.com>
 <20230731093744.GA1788@lst.de>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230731093744.GA1788@lst.de>
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
Cc: brauner@kernel.org, jack@suse.cz, syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, huyue2@coolpad.com, sj1557.seo@samsung.com, linux-erofs@lists.ozlabs.org, linkinjeon@kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/7/31 17:37, Christoph Hellwig wrote:
> On Mon, Jul 31, 2023 at 12:57:58AM -0700, syzbot wrote:
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    d7b3af5a77e8 Add linux-next specific files for 20230728
> 
> Hmm, the current linux-next tree does not seem to have that commit ID
> any more, and the line numbers don't match up.  I think it is the
> WARN_ON for the magic, which could probably be just removed.  I'll
> try the reproducers when I find a bit more time.

Previously, deactivate_locked_super() or .kill_sb() will only be
called after fill_super is called, and .s_magic will be set at
the very beginning of erofs_fc_fill_super().

After ("fs: open block device after superblock creation"), such
convension is changed now.  Yet at a quick glance,

WARN_ON(sb->s_magic != EROFS_SUPER_MAGIC);

in erofs_kill_sb() can be removed since deactivate_locked_super()
will also be called if setup_bdev_super() is falled.  I'd suggest
that removing this WARN_ON() in the related commit, or as
a following commit of the related branch of the pull request if
possible.

Thanks,
Gao Xiang
