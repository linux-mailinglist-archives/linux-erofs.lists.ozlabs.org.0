Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E793182DB76
	for <lists+linux-erofs@lfdr.de>; Mon, 15 Jan 2024 15:40:18 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TDFDJ5VYqz3bhc
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jan 2024 01:40:16 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TDFD92tq8z2xdX
	for <linux-erofs@lists.ozlabs.org>; Tue, 16 Jan 2024 01:40:06 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W-j1yLV_1705329597;
Received: from 30.27.74.27(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W-j1yLV_1705329597)
          by smtp.aliyun-inc.com;
          Mon, 15 Jan 2024 22:39:59 +0800
Message-ID: <931bcf87-efdf-478f-869b-fcb1260ac1cc@linux.alibaba.com>
Date: Mon, 15 Jan 2024 22:39:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] erofs: Don't use certain internal folio_*()
 functions
To: Matthew Wilcox <willy@infradead.org>
References: <20240115083337.1355191-1-hsiangkao@linux.alibaba.com>
 <ZaU75cT0jx9Ya+6G@casper.infradead.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <ZaU75cT0jx9Ya+6G@casper.infradead.org>
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
Cc: Yue Hu <huyue2@coolpad.com>, Jeff Layton <jlayton@kernel.org>, LKML <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org, Christian Brauner <christian@brauner.io>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Matthew,

On 2024/1/15 22:06, Matthew Wilcox wrote:
> On Mon, Jan 15, 2024 at 04:33:37PM +0800, Gao Xiang wrote:
>> From: David Howells <dhowells@redhat.com>
>>
>> Filesystems should use folio->index and folio->mapping, instead of
>> folio_index(folio), folio_mapping() and folio_file_mapping() since
>> they know that it's in the pagecache.
>>
>> Change this automagically with:
>>
>> perl -p -i -e 's/folio_mapping[(]([^)]*)[)]/\1->mapping/g' fs/erofs/*.c
>> perl -p -i -e 's/folio_file_mapping[(]([^)]*)[)]/\1->mapping/g' fs/erofs/*.c
>> perl -p -i -e 's/folio_index[(]([^)]*)[)]/\1->index/g' fs/erofs/*.c
>>
>> Reported-by: Matthew Wilcox <willy@infradead.org>
>> Signed-off-by: David Howells <dhowells@redhat.com>
>> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>> Cc: Chao Yu <chao@kernel.org>
>> Cc: Yue Hu <huyue2@coolpad.com>
>> Cc: Jeffle Xu <jefflexu@linux.alibaba.com>
>> Cc: linux-erofs@lists.ozlabs.org
>> Cc: linux-fsdevel@vger.kernel.org
>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>> ---
>> Hi folks,
>>
>> I tend to apply this patch upstream since compressed data fscache
>> adaption touches this part too.  If there is no objection, I'm
>> going to take this patch separately for -next shortly..
> 
> Could you change the subject?  It's not that the functions are
> "internal", it's that filesystems don't need to use them because they're
> guaranteed to not see swap pages.  Maybe just s/internal/unnecessary/

Yes, the subject line was inherited from the original one.

Such helpers are useful if the type of a folio is unknown,
let me revise it.

Thanks,
Gao Xiang
