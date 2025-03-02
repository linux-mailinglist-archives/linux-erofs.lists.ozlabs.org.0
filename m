Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F54FA4B3E1
	for <lists+linux-erofs@lfdr.de>; Sun,  2 Mar 2025 18:56:37 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z5V4b10CWz30WQ
	for <lists+linux-erofs@lfdr.de>; Mon,  3 Mar 2025 04:56:31 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740938189;
	cv=none; b=Kj8Fykpb/bkHsUcaL9+wm1QY+XvQJpFCFtrQ5uGk4c15PqD7HkCefEsp/cgEq/dPyggqE5GTrVl9PeEWe1JuIjIrCSG3FKOtrqkcBXeQrDNBbKrrevRgLdakl5R6pYBT31QDKaob9aTYSDWu+Ea5t7qaTwKGla8puB/oEng8h6XjPi72q66a4nHdWvncqu6pQ4mIR4fRIhLFQOAbe91QZBShpUbLUzbjvYNTW+BeBkSAZM6Q0RHXyB8jzKtINV00dgWHILwChmbGHBskLhBiPDvNyVEbsQKDwqdIRHMOMx0cY8tRQnVloZimKcce4yg3tUmdge82+uHGO5c9WmajYw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740938189; c=relaxed/relaxed;
	bh=yzXmjFQ4bX2wV3j1beZ3CSsEAZKv6dTZuPoBn8yv2HA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=PVNvILSorwCriP9Fb3AXGIf/sUyzxoiqhlpMTUY+2qfe+1dYP+Zn+8IKZ+WPPrzi5Qwl8wLOf4m6iaFzj82W/kYHYBwLqwgtxAdvW0lpDiRYAO9J+jYllQ5SuKgZe9EJSHKtjE6LIQYmPsVW9dN+JQ6WmLiS/AIYWBAVRcm91UYPVpVYiE+CaGyGKijPczOTGRHLW3B9NeE90Z2dC/s1o++Udn/hYEU557ltJ9xva9Qw7PfqtYSn/JHTFFIZ2n9ndHuDJ2EbrDUyY1UTzjCWnoTBNR0guU5zcoBHvLHQOwpmM6n3swr8/sTB+NOoG/7Mhbdsp8IJ24xcE4BJEfGMlA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=d7bOxsyb; dkim-atps=neutral; spf=pass (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=d7bOxsyb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z5V4W6Q0Cz2yhG
	for <linux-erofs@lists.ozlabs.org>; Mon,  3 Mar 2025 04:56:25 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1740938181; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=yzXmjFQ4bX2wV3j1beZ3CSsEAZKv6dTZuPoBn8yv2HA=;
	b=d7bOxsybGbbcGmhp+rZUS6BYUoA5M09UtodD0+32JzBCyNwnhFLykuwcFfLfd8AaEPD7ozLzk+yAayRDiWCaziy7nAS+dOfnMkkehAbFKyOgSJObk6zJD3wRU7l9+ffkMpRSZChEp5nIamtvkSTgawcPKCHj/CIChLmysBKX4r8=
Received: from 30.134.66.95(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WQVhkCH_1740938169 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 03 Mar 2025 01:56:19 +0800
Message-ID: <131cd204-036d-4d78-ae80-4ff5b8aedb09@linux.alibaba.com>
Date: Mon, 3 Mar 2025 01:56:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 1/2] erofs: handle overlapped pclusters out of crafted
 images properly
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Fedor Pchelkin <pchelkin@ispras.ru>, Alexey Panov <apanov@astralinux.ru>
References: <20250228165103.26775-1-apanov@astralinux.ru>
 <20250228165103.26775-2-apanov@astralinux.ru>
 <kcsbxadkk4wow7554zonb6cjvzmkh2pbncsvioloucv3npvbtt@rpthpmo7cjja>
 <fb801c0f-105e-4aa7-80e2-fcf622179446@linux.alibaba.com>
In-Reply-To: <fb801c0f-105e-4aa7-80e2-fcf622179446@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Cc: Max Kellermann <max.kellermann@ionos.com>, lvc-project@linuxtesting.org, syzbot+de04e06b28cfecf2281c@syzkaller.appspotmail.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Chao Yu <chao@kernel.org>, linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Yue Hu <huyue2@coolpad.com>, syzbot+4fc98ed414ae63d1ada2@syzkaller.appspotmail.com, syzbot+c8c8238b394be4a1087d@syzkaller.appspotmail.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2025/3/3 01:41, Gao Xiang wrote:
> Hi Fedor,
> 
> On 2025/3/2 18:56, Fedor Pchelkin wrote:
>> On Fri, 28. Feb 19:51, Alexey Panov wrote:
>>> From: Gao Xiang <hsiangkao@linux.alibaba.com>
>>>
>>> commit 9e2f9d34dd12e6e5b244ec488bcebd0c2d566c50 upstream.
>>>
>>> syzbot reported a task hang issue due to a deadlock case where it is
>>> waiting for the folio lock of a cached folio that will be used for
>>> cache I/Os.
>>>
>>> After looking into the crafted fuzzed image, I found it's formed with
>>> several overlapped big pclusters as below:
>>>
>>>   Ext:   logical offset   |  length :     physical offset    |  length
>>>     0:        0..   16384 |   16384 :     151552..    167936 |   16384
>>>     1:    16384..   32768 |   16384 :     155648..    172032 |   16384
>>>     2:    32768..   49152 |   16384 :  537223168.. 537239552 |   16384
>>> ...
>>>
>>> Here, extent 0/1 are physically overlapped although it's entirely
>>> _impossible_ for normal filesystem images generated by mkfs.
>>>
>>> First, managed folios containing compressed data will be marked as
>>> up-to-date and then unlocked immediately (unlike in-place folios) when
>>> compressed I/Os are complete.  If physical blocks are not submitted in
>>> the incremental order, there should be separate BIOs to avoid dependency
>>> issues.  However, the current code mis-arranges z_erofs_fill_bio_vec()
>>> and BIO submission which causes unexpected BIO waits.
>>>
>>> Second, managed folios will be connected to their own pclusters for
>>> efficient inter-queries.  However, this is somewhat hard to implement
>>> easily if overlapped big pclusters exist.  Again, these only appear in
>>> fuzzed images so let's simply fall back to temporary short-lived pages
>>> for correctness.
>>>
>>> Additionally, it justifies that referenced managed folios cannot be
>>> truncated for now and reverts part of commit 2080ca1ed3e4 ("erofs: tidy
>>> up `struct z_erofs_bvec`") for simplicity although it shouldn't be any
>>> difference.
>>>
>>> Reported-by: syzbot+4fc98ed414ae63d1ada2@syzkaller.appspotmail.com
>>> Reported-by: syzbot+de04e06b28cfecf2281c@syzkaller.appspotmail.com
>>> Reported-by: syzbot+c8c8238b394be4a1087d@syzkaller.appspotmail.com
>>> Tested-by: syzbot+4fc98ed414ae63d1ada2@syzkaller.appspotmail.com
>>> Closes: https://lore.kernel.org/r/0000000000002fda01061e334873@google.com
>>> Fixes: 8e6c8fa9f2e9 ("erofs: enable big pcluster feature")
>>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>>> Link: https://lore.kernel.org/r/20240910070847.3356592-1-hsiangkao@linux.alibaba.com
>>> [Alexey: minor fix to resolve merge conflict]
>>
>> Urgh, it doesn't look so minor indeed. Backward struct folio -> struct
>> page conversions can be tricky sometimes. Please see several comments
>> below.
> 
> I manually backported it for Linux 6.6.y, see
> https://web.git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-6.6.y&id=1bf7e414cac303c9aec1be67872e19be8b64980c
> 
> Actually I had a very similiar backport for Linux 6.1.y,
> but I forgot to send it out due to other ongoing stuffs.
> 
> I think this backport patch is all good, but you could
> also mention it follows linux 6.6.y conflict changes
> instead of "minor fix to resolve merge conflict".
> 
>>
>>> Signed-off-by: Alexey Panov <apanov@astralinux.ru>
>>> ---
>>> Backport fix for CVE-2024-47736
>>>
>>>   fs/erofs/zdata.c | 59 +++++++++++++++++++++++++-----------------------
>>>   1 file changed, 31 insertions(+), 28 deletions(-)
>>>
>>> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
>>> index 94e9e0bf3bbd..ac01c0ede7f7 100644
>>
>> I'm looking at the diff of upstream commit and the first thing it does
>> is to remove zeroing out the folio/page private field here:
>>
>>    // upstream commit 9e2f9d34dd12 ("erofs: handle overlapped pclusters out of crafted images properly")
>>    @@ -1450,7 +1451,6 @@ static void z_erofs_fill_bio_vec(struct bio_vec *bvec,
>>             * file-backed folios will be used instead.
>>             */
>>            if (folio->private == (void *)Z_EROFS_PREALLOCATED_PAGE) {
>>    -               folio->private = 0;
>>                    tocache = true;
>>                    goto out_tocache;
>>            }
>>
>> while in 6.1.129 the corresponding fragment seems untouched with the
>> backport patch. Is it intended?
> 
> Yes, because it was added in
> commit 2080ca1ed3e4 ("erofs: tidy up `struct z_erofs_bvec`")
> and dropped again.
> 
> But for Linux 6.6.y and 6.1.y, we don't need to backport
> 2080ca1ed3e4.

Oh, it seems that I missed this part when backporting
for 6.6.y, but it has no actual difference because
`page->private` will be updated in `goto out_tocache`.

so `set_page_private(page, 0);` was actual a redundant
logic, you could follow the upstream to discard
`set_page_private(page, 0);`.

Thanks,
Gao Xiang
