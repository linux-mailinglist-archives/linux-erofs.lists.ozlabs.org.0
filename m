Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 089FE971E48
	for <lists+linux-erofs@lfdr.de>; Mon,  9 Sep 2024 17:40:31 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X2WHw5fVdz2yXY
	for <lists+linux-erofs@lfdr.de>; Tue, 10 Sep 2024 01:40:28 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.113
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725896425;
	cv=none; b=FbcQgv/y5XVULKRgl6dTcTN9pafQvkALydFq4xOb2qSDNa+UcpCwlNpXyo4FJxnigJpvTajk+3tfINdGTar8Mo6c0sbKnbIxpJ8iK9vk3SwIRY3YS/VfcFINHV1iUIzRTs3fB7moHQorvQ2PS7aFNOp/5wTxVZoIrjMAL83MgQwoDSF1CNoFoReZPcD1TnOX/EDdrhcx3jrSPMSbagcVEK0zu+Y3e8O9YZM78mOG+FXlwv3nRVYeOfV9qhRc29JKKbKkdpU35lzBrBYmVvmmsooetItMavDP8Xftq3c0U+/x6P3aSOESi76owvsgjsrar64wxwjVoWA9fdjG1HN4Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725896425; c=relaxed/relaxed;
	bh=YIYQsQqU7SRbe/99jsN7MhA0jKoE0V/rgii7buJK1JY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=op6bdMmnWp+Xkm3X12UevWCb/w+3O7tMxw72MlI5AMF3PKIeI55YgvX6FR/DfbXjrLCkg4XDs8dKkzPORscEP5t+ka0BTmS03XLLVjZ9b0HRoDzvIbu97eZpbTJveLZrIncbensaZmwAeYD841zWMhKtVNB1e1xQ/CDJk+Zt4COerrpAqqKsgTx+M5LVDkNFrqp7VSW6UZbW/eBiVFVhqOaELxau9Pn89doBOlAtFUe218UN1yxI2ssYl//AtYA1VGeffV6FUidWI0JddwlOPwHXRNgqdgo33M7K9HW7OxXgCrBJh4oG5Vb6IyUX8nEKs/wFIYAQKB4GRXl+VX3Qyg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=feomIxPN; dkim-atps=neutral; spf=pass (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=feomIxPN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X2WHr2LwBz2yTs
	for <linux-erofs@lists.ozlabs.org>; Tue, 10 Sep 2024 01:40:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725896418; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=YIYQsQqU7SRbe/99jsN7MhA0jKoE0V/rgii7buJK1JY=;
	b=feomIxPN0Rdyr7fP9fpLtSG9SUdC/CSMBIINTiP0qbKUjJimoymqSGAH7pQt53LX13jADzXi98zDkjQiATMTojgCn+Jo4Y9dy38PqE9L1804hassbrgYx5qhaJAn/YtcQ0A8d//AduEASaoFeo4Z6vwXIrvVvF0QYGWG64RLils=
Received: from 192.168.2.29(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WEgzJpI_1725896414)
          by smtp.aliyun-inc.com;
          Mon, 09 Sep 2024 23:40:15 +0800
Message-ID: <f8a965ed-e962-40a8-8287-943e872d238c@linux.alibaba.com>
Date: Mon, 9 Sep 2024 23:40:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] erofs: fix incorrect symlink detection in fast symlink
To: Colin Walters <walters@verbum.org>, linux-erofs@lists.ozlabs.org
References: <20240909022811.1105052-1-hsiangkao@linux.alibaba.com>
 <20240909031911.1174718-1-hsiangkao@linux.alibaba.com>
 <bb2dd430-7de0-47da-ae5b-82ab2dd4d945@app.fastmail.com>
 <25f0356d-d949-483c-8e59-ddc9cace61f6@linux.alibaba.com>
 <21ddadb7-407d-48b6-9c1b-845ead2eefb4@app.fastmail.com>
 <df09821e-d7ca-4bfb-8f57-2046c072af62@linux.alibaba.com>
 <91310d4c-98d5-4a8b-b3db-2043d4a3d533@app.fastmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <91310d4c-98d5-4a8b-b3db-2043d4a3d533@app.fastmail.com>
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
Cc: LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/9/9 22:46, Colin Walters wrote:
> 
> 
> On Mon, Sep 9, 2024, at 10:14 AM, Gao Xiang wrote:
>>
>> Not quite sure about hard limitation in EROFS
>> runtime, we could define
>>
>> #define EROFS_SYMLINK_MAXLEN	4096
> 
> Not sure that a new define is needed versus just reusing PATH_MAX, but that's obviously just a style thing that's much more your call than mine.
> 
>> But since symlink i_size > 4096 only due to crafted
>> images (and not generated by mkfs) and not crash, so
>> either way (to check or not check in kernel) is okay
>> to me.
> 
> Yes, but my understanding was that EROFS (in contrast to other kernel read-write filesystems which are more complicated) was aiming to be robust against potentially malicious images.

Just my personal opinion, my understanding of rubustness
is stability and security.

But whether to check or not check this, it doesn't crash
the kernel or deadlock or livelock, so IMHO, it's already
rubustness.

Actually, I think EROFS for i_size > PAGE_SIZE, it's an
undefined or reserved behavior for now (just like CPU
reserved bits or don't care bits), just Linux
implementation treats it with PAGE_SIZE-1 trailing '\0',
but using erofs dump tool you could still dump large
symlinks.

Since PATH_MAX is a system-defined constant too, currently
Linux PATH_MAX is 4096, but how about other OSes? I've
seen some `PATH_MAX 8192` reference but I'm not sure which
OS uses this setting.

But I think it's a filesystem on-disk limitation, but if
i_size exceeds that, we return -EOPNOTSUPP or -EFSCORRUPTED?
For this symlink case, I tend to return -EFSCORRUPTED but
for other similar but complex cases, it could be hard to
decide.

Leaving them as undefined behaviors are also an option as
long as the behavior is secure.

> 
> Crafted/malicious images aside, there's also the IMO obvious angle here that we should avoid crashes or worse out-of-bound read/write if there happens to be *accidental* on-disk/memory corruption and having high bit(s) flip in a symlink inode size seems like an easy one to handle. Skimming the XFS code for example it looks like it's pretty robust in this area.

Yes, for this case it's much simple and easy so that's
fine, but I think for some other cases, leaving some
undefined or reserved behaviors are also good for later
extendability (again, like CPU register design.) as long
as it doesn't cause security issues.

Thanks,
Gao Xiang

