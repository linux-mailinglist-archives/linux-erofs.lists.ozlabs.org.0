Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0BDA4B5A4
	for <lists+linux-erofs@lfdr.de>; Mon,  3 Mar 2025 01:32:21 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z5fs45LNyz30VY
	for <lists+linux-erofs@lfdr.de>; Mon,  3 Mar 2025 11:32:08 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.112
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740961926;
	cv=none; b=JVVXmlHFpLt19NZQS17qXtIFD7PmmHyliG8oo8IUreGwU3z8FWyVmt0Zh3kjGg9B6J9VI64NIQiO/Re5n/lz9GQ0p7D1osBqljh9kGqa8cgUFb66qDRk7SlKbSmzQWRNZj/NXunExEZn4B91WtDDisjW70QTwU+ngErtQ4flGWoS8L74ljITe9PdIXC8eMOs8SbuGJ/Qv6ddFB9gB+ADQdoEnQfvoUMr5Ev5fyHKJIOHv/e9vtscDHgPXv1qNhZebRo3NU8cGCVSeHzkJXyKdXu1pkDA2gQuPKxSD4CBnR4JhIVb18JdvJ0h9buFLWIaArQbeZT2KqzcIrAv0R3k7g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740961926; c=relaxed/relaxed;
	bh=vWRFE5MRPeFedN8U4K/7JNMCa/lHFzfHJwZRS5nIybA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LaJXgQ8jCKuyzUi48HtJmFBECrP1PZQbD5hqUKTOm2Pr4kMq5+qKm6CHOt+pTaU838Z1GtYkBnrCvalHBC7cPqSt2pcZ/JpVk/M1CbgT53hAyJ8sGpBkfGqKSpdUrSi25XIN/5BPlRlUFGouDWwkNrxo57JH4plz1nAJYsFo3mvqPJ6gBbH1buC7Mk7l43FqZi7R13GlRkNoxQNkF/NLKGjrEknJO0GBDGGOnLvW0atr1kZjBcGYlLFqvpPNI8fC/vHXFkrda8xePixrNZsUkzrhMVoGllxrWlCp6esKZqzy7FAx04SNZQpOK6uYCVocwvezuH6mkK9hComteo2rJw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=pJkhxuEo; dkim-atps=neutral; spf=pass (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=pJkhxuEo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z5fry69hVz2ynf
	for <linux-erofs@lists.ozlabs.org>; Mon,  3 Mar 2025 11:32:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1740961916; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=vWRFE5MRPeFedN8U4K/7JNMCa/lHFzfHJwZRS5nIybA=;
	b=pJkhxuEouvzJBRuqFe3JYbpp9tEunZOQtdMUPrHzWtgh1fKJIQbqrLkjGxTw5PQf44/euc3R70O41FQUrtUZIHclsjGGG/RQMmj3nYCfRFPxFobgrOnE6GkGCaPpQO0QsjqPyK57sS1x0XopqdAQ/FjY7pdoO8FmAMr0EVcyjA8=
Received: from 30.134.66.95(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WQWCbQv_1740961904 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 03 Mar 2025 08:31:54 +0800
Message-ID: <0417518e-d02e-48a9-a9ce-8d2be53bc1bd@linux.alibaba.com>
Date: Mon, 3 Mar 2025 08:31:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 1/2] erofs: handle overlapped pclusters out of crafted
 images properly
To: Fedor Pchelkin <pchelkin@ispras.ru>
References: <20250228165103.26775-1-apanov@astralinux.ru>
 <20250228165103.26775-2-apanov@astralinux.ru>
 <kcsbxadkk4wow7554zonb6cjvzmkh2pbncsvioloucv3npvbtt@rpthpmo7cjja>
 <fb801c0f-105e-4aa7-80e2-fcf622179446@linux.alibaba.com>
 <3vutme7tf24cqdfbf4wjti22u6jfxjewe6gt4ufppp4xplyb5e@xls7aozstoqr>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <3vutme7tf24cqdfbf4wjti22u6jfxjewe6gt4ufppp4xplyb5e@xls7aozstoqr>
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
Cc: Max Kellermann <max.kellermann@ionos.com>, lvc-project@linuxtesting.org, syzbot+de04e06b28cfecf2281c@syzkaller.appspotmail.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Chao Yu <chao@kernel.org>, linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Alexey Panov <apanov@astralinux.ru>, Yue Hu <huyue2@coolpad.com>, syzbot+4fc98ed414ae63d1ada2@syzkaller.appspotmail.com, syzbot+c8c8238b394be4a1087d@syzkaller.appspotmail.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2025/3/3 02:13, Fedor Pchelkin wrote:
> On Mon, 03. Mar 01:41, Gao Xiang wrote:
>>>> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
>>>> index 94e9e0bf3bbd..ac01c0ede7f7 100644
>>>
>>> I'm looking at the diff of upstream commit and the first thing it does
>>> is to remove zeroing out the folio/page private field here:
>>>
>>>     // upstream commit 9e2f9d34dd12 ("erofs: handle overlapped pclusters out of crafted images properly")
>>>     @@ -1450,7 +1451,6 @@ static void z_erofs_fill_bio_vec(struct bio_vec *bvec,
>>>              * file-backed folios will be used instead.
>>>              */
>>>             if (folio->private == (void *)Z_EROFS_PREALLOCATED_PAGE) {
>>>     -               folio->private = 0;
>>>                     tocache = true;
>>>                     goto out_tocache;
>>>             }
>>>
>>> while in 6.1.129 the corresponding fragment seems untouched with the
>>> backport patch. Is it intended?
>>
>> Yes, because it was added in
>> commit 2080ca1ed3e4 ("erofs: tidy up `struct z_erofs_bvec`")
>> and dropped again.
>>
>> But for Linux 6.6.y and 6.1.y, we don't need to backport
>> 2080ca1ed3e4.
> 
> Thanks for overall clarification, Gao!
> 
> My concern was that in 6.1 and 6.6 there is still a pattern at that
> place, not directly related to 2080ca1ed3e4 ("erofs: tidy up
> `struct z_erofs_bvec`"):
> 
> 1. checking ->private against Z_EROFS_PREALLOCATED_PAGE
> 2. zeroing out ->private if the previous check holds true
> 
> // 6.1/6.6 fragment
> 
> 	if (page->private == Z_EROFS_PREALLOCATED_PAGE) {
> 		WRITE_ONCE(pcl->compressed_bvecs[nr].page, page);
> 		set_page_private(page, 0);
> 		tocache = true;
> 		goto out_tocache;
> 	}
> 
> while the upstream patch changed the situation. If it's okay then no
> remarks from me. Sorry for the noise..

Yeah, yet as I mentioned `set_page_private(page, 0);`
seems redundant from the codebase, I'm fine with either
way.

Thanks,
Gao Xiang
