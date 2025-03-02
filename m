Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id DF738A4B3D8
	for <lists+linux-erofs@lfdr.de>; Sun,  2 Mar 2025 18:41:30 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z5TlC2j9Cz30W4
	for <lists+linux-erofs@lfdr.de>; Mon,  3 Mar 2025 04:41:27 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740937285;
	cv=none; b=StDbm+ANmf2zMzqjAs5CQ/XFpq+aZcDyAO1RrAhg/XCgrn6SctkQLBrQ9EUkvZ2y3fIINUl7lElxaK0ka5705bOCZVS31CvnwdoQJXkoZ8XpESAThu2Moql3T3rMJsR/8AUJoSx/12L44rskxMSz2Oe8NgAV3ssZ6+w5kSL5K6I+YYqJmmzhigYnuYJgFJkMzQQVYiBUAv5/MJMofO0o4m3J1Imc6/VB2FtdIDgPZual8g6HTNvjYQuMB8ic/XB5UN5XFbPhkQO8KDPoY9HP+kepgExCNA93SpeZaf8X+McWRKYMq0XMDgLfjeHmUXYW1IdlYfhJhckc8LA638Nl+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740937285; c=relaxed/relaxed;
	bh=KZ9077j2t/O7npcJX5TWpK77XthXqhjTIeAzp6ONbxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S2cQsWEkl7AWvU3DDqgVBSleJD3ADa6oIhiTUSd8su6dk0EcueCFiBghFXAfuS3O9VNjuU5rW+1pcBcb/3hNlhegYMiNFPXICf/nC+AEA5NDmxJEtTP3H8EwQG2pXrNURvlLLsjrgrrc0kmmXTg8vm6OIwuOJlSXg26dGGXSnaCd1hUN4dUzCcvNqKSITH28qzRPM1NYq9tDb/ogGpmxsUkCxzYde5yw8pUuNKN3oC+3d+4zXOiELyllz56zphg13/3NVU9fmtWHsRRZuaK0vlhvQ3fTKAOiarSDRWENSlIvgbsaFILiqJ/6yR2GrX6tvt6/bzxRA25zGdWnyq/dYA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ROTJ5Fnf; dkim-atps=neutral; spf=pass (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ROTJ5Fnf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z5Tl761nrz2yN3
	for <linux-erofs@lists.ozlabs.org>; Mon,  3 Mar 2025 04:41:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1740937277; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=KZ9077j2t/O7npcJX5TWpK77XthXqhjTIeAzp6ONbxg=;
	b=ROTJ5FnfNtZ9TXI1h9W+nHbl7Rwp0iBJJ2V0SHDszFk9dzI1FEiRXY/hA9h9dd0C6yuRBxmU+CMlC8CbJCP5nYU0Iua0DysrbkmgLLEgP9TfqY/TALWV5ijmb9O63KyLgsb1bQYYaX08NxPmWeGTXrmVw3n4kq8VdmirsE1CGMg=
Received: from 30.134.66.95(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WQVZhGy_1740937265 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 03 Mar 2025 01:41:14 +0800
Message-ID: <fb801c0f-105e-4aa7-80e2-fcf622179446@linux.alibaba.com>
Date: Mon, 3 Mar 2025 01:41:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 1/2] erofs: handle overlapped pclusters out of crafted
 images properly
To: Fedor Pchelkin <pchelkin@ispras.ru>, Alexey Panov <apanov@astralinux.ru>
References: <20250228165103.26775-1-apanov@astralinux.ru>
 <20250228165103.26775-2-apanov@astralinux.ru>
 <kcsbxadkk4wow7554zonb6cjvzmkh2pbncsvioloucv3npvbtt@rpthpmo7cjja>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <kcsbxadkk4wow7554zonb6cjvzmkh2pbncsvioloucv3npvbtt@rpthpmo7cjja>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi Fedor,

On 2025/3/2 18:56, Fedor Pchelkin wrote:
> On Fri, 28. Feb 19:51, Alexey Panov wrote:
>> From: Gao Xiang <hsiangkao@linux.alibaba.com>
>>
>> commit 9e2f9d34dd12e6e5b244ec488bcebd0c2d566c50 upstream.
>>
>> syzbot reported a task hang issue due to a deadlock case where it is
>> waiting for the folio lock of a cached folio that will be used for
>> cache I/Os.
>>
>> After looking into the crafted fuzzed image, I found it's formed with
>> several overlapped big pclusters as below:
>>
>>   Ext:   logical offset   |  length :     physical offset    |  length
>>     0:        0..   16384 |   16384 :     151552..    167936 |   16384
>>     1:    16384..   32768 |   16384 :     155648..    172032 |   16384
>>     2:    32768..   49152 |   16384 :  537223168.. 537239552 |   16384
>> ...
>>
>> Here, extent 0/1 are physically overlapped although it's entirely
>> _impossible_ for normal filesystem images generated by mkfs.
>>
>> First, managed folios containing compressed data will be marked as
>> up-to-date and then unlocked immediately (unlike in-place folios) when
>> compressed I/Os are complete.  If physical blocks are not submitted in
>> the incremental order, there should be separate BIOs to avoid dependency
>> issues.  However, the current code mis-arranges z_erofs_fill_bio_vec()
>> and BIO submission which causes unexpected BIO waits.
>>
>> Second, managed folios will be connected to their own pclusters for
>> efficient inter-queries.  However, this is somewhat hard to implement
>> easily if overlapped big pclusters exist.  Again, these only appear in
>> fuzzed images so let's simply fall back to temporary short-lived pages
>> for correctness.
>>
>> Additionally, it justifies that referenced managed folios cannot be
>> truncated for now and reverts part of commit 2080ca1ed3e4 ("erofs: tidy
>> up `struct z_erofs_bvec`") for simplicity although it shouldn't be any
>> difference.
>>
>> Reported-by: syzbot+4fc98ed414ae63d1ada2@syzkaller.appspotmail.com
>> Reported-by: syzbot+de04e06b28cfecf2281c@syzkaller.appspotmail.com
>> Reported-by: syzbot+c8c8238b394be4a1087d@syzkaller.appspotmail.com
>> Tested-by: syzbot+4fc98ed414ae63d1ada2@syzkaller.appspotmail.com
>> Closes: https://lore.kernel.org/r/0000000000002fda01061e334873@google.com
>> Fixes: 8e6c8fa9f2e9 ("erofs: enable big pcluster feature")
>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>> Link: https://lore.kernel.org/r/20240910070847.3356592-1-hsiangkao@linux.alibaba.com
>> [Alexey: minor fix to resolve merge conflict]
> 
> Urgh, it doesn't look so minor indeed. Backward struct folio -> struct
> page conversions can be tricky sometimes. Please see several comments
> below.

I manually backported it for Linux 6.6.y, see
https://web.git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-6.6.y&id=1bf7e414cac303c9aec1be67872e19be8b64980c

Actually I had a very similiar backport for Linux 6.1.y,
but I forgot to send it out due to other ongoing stuffs.

I think this backport patch is all good, but you could
also mention it follows linux 6.6.y conflict changes
instead of "minor fix to resolve merge conflict".

> 
>> Signed-off-by: Alexey Panov <apanov@astralinux.ru>
>> ---
>> Backport fix for CVE-2024-47736
>>
>>   fs/erofs/zdata.c | 59 +++++++++++++++++++++++++-----------------------
>>   1 file changed, 31 insertions(+), 28 deletions(-)
>>
>> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
>> index 94e9e0bf3bbd..ac01c0ede7f7 100644
> 
> I'm looking at the diff of upstream commit and the first thing it does
> is to remove zeroing out the folio/page private field here:
> 
>    // upstream commit 9e2f9d34dd12 ("erofs: handle overlapped pclusters out of crafted images properly")
>    @@ -1450,7 +1451,6 @@ static void z_erofs_fill_bio_vec(struct bio_vec *bvec,
>             * file-backed folios will be used instead.
>             */
>            if (folio->private == (void *)Z_EROFS_PREALLOCATED_PAGE) {
>    -               folio->private = 0;
>                    tocache = true;
>                    goto out_tocache;
>            }
> 
> while in 6.1.129 the corresponding fragment seems untouched with the
> backport patch. Is it intended?

Yes, because it was added in
commit 2080ca1ed3e4 ("erofs: tidy up `struct z_erofs_bvec`")
and dropped again.

But for Linux 6.6.y and 6.1.y, we don't need to backport
2080ca1ed3e4.

Thanks,
Gao Xiang
