Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2461E99E40E
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Oct 2024 12:34:44 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XSVpT6gVgz3bpS
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Oct 2024 21:34:41 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1728988480;
	cv=none; b=IVj+xERrMEqD+YlbrZbFSToNX5gw99Yhu0nnVpPkUC0byNm3IJF5GJJl5Abavt9GejUYCyNf6v+3l8TiF8mDTfTsTCjnFa4+Q181anHoSbB7PpOxcsO8u76rioXNb0w0Us9XJZr9Q/0Kd6o3E2Gh154ItukQF7B2AV01RJ/o7eB4LCsc3Pfg6bDEaC8zfBnynlb49Z2jkfCFiW/i0yQNCXtaQfkVDaiKAJnEra2AfglvEqt8RI6a5NgfgJKSJwARYJRIU7iTakuE7no8AYGib085n3QTkgTjcesIZ/73FIWy8s34caUAba6A0La68L9Vah143/+cU4eEN9nLtbYeBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1728988480; c=relaxed/relaxed;
	bh=rY+7tRwbhEa9NRr1LWtSOufpGMP2qFins0pVb8gCf08=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=HFKrZE/YDKP71lyF19YeYzj4yA0YTeozVGcXj5L0ofFaXldRgr3y2FuU63JOyhEMuTCHoV3YnF0OCVRQhYJz1hl3yCOY3NfBdG5oejyjPcRtk59UCJMugdKlrx5cXoCgYAYoRTP7ev/Jfo4qm+rDFCn0pbpWfQY4KhZtmnKAq6mNY1e7ZMxrHMh5st/vP/z06PXfe31o74qJd4lE0PONrqpa3NXdN1WB9TcRyUAH8X9EsMrZxWM4yGlLQxsa9QFf20US21bxAVWS7e53Sf4cZIRtH1RkuKauQxqsOA7gstHE5Wc0f39+tWH7uFgdogUo62Fa+5rzjhjHzwvbbpNZoA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=bZBo6/jH; dkim-atps=neutral; spf=pass (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=bZBo6/jH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XSVpK5MR5z3bkf
	for <linux-erofs@lists.ozlabs.org>; Tue, 15 Oct 2024 21:34:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728988464; h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:From;
	bh=rY+7tRwbhEa9NRr1LWtSOufpGMP2qFins0pVb8gCf08=;
	b=bZBo6/jHRaocaoS5tB1Su5Vq7nk1iqSOcg5wdGbUlEYK/Jq3KngFs/v/Vvae4YkU0n7seg1yUIpxJpo1LFATpXXOhoJpbSMrHvJ4RezbVHj44AHqPBRevbsyP3I213cf+D+Ll0fP7LKkfez+xMRtWPzG3Xxo4VMnD+71Jqz2DSQ=
Received: from 30.221.131.163(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WHDRFEq_1728988463 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 15 Oct 2024 18:34:24 +0800
Content-Type: multipart/alternative;
 boundary="------------2vpXlp0bPm3k17s4EV0KpwP6"
Message-ID: <0445fd69-8236-4e09-b2b4-0ac57882229e@linux.alibaba.com>
Date: Tue, 15 Oct 2024 18:34:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] erofs: fix blksize < PAGE_SIZE for file-backed mounts
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20241015070750.3489603-1-hongzhen@linux.alibaba.com>
 <b0c38bac-a682-45ae-8991-b73991ae6ddb@linux.alibaba.com>
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
In-Reply-To: <b0c38bac-a682-45ae-8991-b73991ae6ddb@linux.alibaba.com>
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,HTML_MESSAGE,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
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
Cc: linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This is a multi-part message in MIME format.
--------------2vpXlp0bPm3k17s4EV0KpwP6
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2024/10/15 15:52, Gao Xiang wrote:
>
>
> On 2024/10/15 15:07, Hongzhen Luo wrote:
>> Adjust sb->s_blocksize{,_bits} directly for file-backed
>> mounts when the fs block size is smaller than PAGE_SIZE.
>>
>> Previously, EROFS used sb_set_blocksize(), which caused
>> a panic if bdev-backed mounts is not used.
>>
>> Fixes: fb176750266a ("erofs: add file-backed mount support")
>> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
>> ---
>> v3: Fix trivial typos.
>> v2: 
>> https://lore.kernel.org/linux-erofs/20241015064007.3449582-1-hongzhen@linux.alibaba.com/
>> v1: 
>> https://lore.kernel.org/linux-erofs/20241015033601.3206952-1-hongzhen@linux.alibaba.com/
>> ---
>>   fs/erofs/super.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
>> index 320d586c3896..ca45dfb17d7c 100644
>> --- a/fs/erofs/super.c
>> +++ b/fs/erofs/super.c
>> @@ -631,7 +631,11 @@ static int erofs_fc_fill_super(struct 
>> super_block *sb, struct fs_context *fc)
>>               errorfc(fc, "unsupported blksize for fscache mode");
>>               return -EINVAL;
>>           }
>> -        if (!sb_set_blocksize(sb, 1 << sbi->blkszbits)) {
>> +
>> +        if (erofs_is_fileio_mode(sbi)) {
>> +            sb->s_blocksize = (1 << sbi->blkszbits);
>
> Why needing parentheses here?
>
> Thanks,
> Gao Xiang

I will resend a version without the parentheses soon.

---

Thanks,

Hongzhen

>
>> +            sb->s_blocksize_bits = sbi->blkszbits;
>> +        } else if (!sb_set_blocksize(sb, 1 << sbi->blkszbits)) {
>>               errorfc(fc, "failed to set erofs blksize");
>>               return -EINVAL;
>>           }
--------------2vpXlp0bPm3k17s4EV0KpwP6
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2024/10/15 15:52, Gao Xiang wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:b0c38bac-a682-45ae-8991-b73991ae6ddb@linux.alibaba.com">
      <br>
      <br>
      On 2024/10/15 15:07, Hongzhen Luo wrote:
      <br>
      <blockquote type="cite">Adjust sb-&gt;s_blocksize{,_bits} directly
        for file-backed
        <br>
        mounts when the fs block size is smaller than PAGE_SIZE.
        <br>
        <br>
        Previously, EROFS used sb_set_blocksize(), which caused
        <br>
        a panic if bdev-backed mounts is not used.
        <br>
        <br>
        Fixes: fb176750266a ("erofs: add file-backed mount support")
        <br>
        Signed-off-by: Hongzhen Luo <a class="moz-txt-link-rfc2396E" href="mailto:hongzhen@linux.alibaba.com">&lt;hongzhen@linux.alibaba.com&gt;</a>
        <br>
        ---
        <br>
        v3: Fix trivial typos.
        <br>
        v2:
<a class="moz-txt-link-freetext" href="https://lore.kernel.org/linux-erofs/20241015064007.3449582-1-hongzhen@linux.alibaba.com/">https://lore.kernel.org/linux-erofs/20241015064007.3449582-1-hongzhen@linux.alibaba.com/</a><br>
        v1:
<a class="moz-txt-link-freetext" href="https://lore.kernel.org/linux-erofs/20241015033601.3206952-1-hongzhen@linux.alibaba.com/">https://lore.kernel.org/linux-erofs/20241015033601.3206952-1-hongzhen@linux.alibaba.com/</a><br>
        ---
        <br>
          fs/erofs/super.c | 6 +++++-
        <br>
          1 file changed, 5 insertions(+), 1 deletion(-)
        <br>
        <br>
        diff --git a/fs/erofs/super.c b/fs/erofs/super.c
        <br>
        index 320d586c3896..ca45dfb17d7c 100644
        <br>
        --- a/fs/erofs/super.c
        <br>
        +++ b/fs/erofs/super.c
        <br>
        @@ -631,7 +631,11 @@ static int erofs_fc_fill_super(struct
        super_block *sb, struct fs_context *fc)
        <br>
                      errorfc(fc, "unsupported blksize for fscache
        mode");
        <br>
                      return -EINVAL;
        <br>
                  }
        <br>
        -        if (!sb_set_blocksize(sb, 1 &lt;&lt;
        sbi-&gt;blkszbits)) {
        <br>
        +
        <br>
        +        if (erofs_is_fileio_mode(sbi)) {
        <br>
        +            sb-&gt;s_blocksize = (1 &lt;&lt;
        sbi-&gt;blkszbits);
        <br>
      </blockquote>
      <br>
      Why needing parentheses here?
      <br>
      <br>
      Thanks,
      <br>
      Gao Xiang
      <br>
    </blockquote>
    <p>I will resend a version without the parentheses soon.<span
style="color: rgb(51, 51, 51); font-family: PingFangSC-Regular; font-size: 14px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-line; background-color: rgb(249, 250, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;"></span></p>
    <p>---</p>
    <p>Thanks,</p>
    <p>Hongzhen<br>
    </p>
    <blockquote type="cite"
      cite="mid:b0c38bac-a682-45ae-8991-b73991ae6ddb@linux.alibaba.com">
      <br>
      <blockquote type="cite">+            sb-&gt;s_blocksize_bits =
        sbi-&gt;blkszbits;
        <br>
        +        } else if (!sb_set_blocksize(sb, 1 &lt;&lt;
        sbi-&gt;blkszbits)) {
        <br>
                      errorfc(fc, "failed to set erofs blksize");
        <br>
                      return -EINVAL;
        <br>
                  }
        <br>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------2vpXlp0bPm3k17s4EV0KpwP6--
