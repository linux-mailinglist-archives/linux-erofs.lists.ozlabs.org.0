Return-Path: <linux-erofs+bounces-3300-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wC5RGuNo3mmxDgAAu9opvQ
	(envelope-from <linux-erofs+bounces-3300-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Apr 2026 18:18:43 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 279693FC739
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Apr 2026 18:18:42 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fw8bL4FB0z2yVL;
	Wed, 15 Apr 2026 02:18:38 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=47.90.199.10
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776183518;
	cv=none; b=SGw/WXQUR/wR19S/2/TH5W13XRgqrGYpip8/aju/+CVkaBGNbt8PiVjOOT3otre69aJvDmyDgRWhvJvTU6lQjM+JKKyT8Y+G00gVisC3AEAX8N1wAGld64NMsR5/EH/7i073NGogoSnC6RVIob4yBTjhi8HHo06bQnPOwmdM7e7eeGXeHXSd1c2WX6sO3O7wQbx0Hv/ydy6U1y/k+a8R5G8rlRlxNGTL1XG4PQMwtpN3mmXlCPfw0k13PlwtBt8hM5Ru2tUG9UpMlMEPrJWQKx0voHGaiX/QQ0Zi2ObS7Jw3X4aOXKA/GbyPVBlt2rl62HyOoh+S0c25SENTDtbEFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776183518; c=relaxed/relaxed;
	bh=aRCg1Ohq04OYnRp+wabVrBC782Swic30XU0PY1//jLQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=AV2o7p6AYEwg2stvSCNvIvDxa+IgmukbXZ2RReMeJrgUqzqnp2K1VURferZwEokgQ+yrEAdHDUcvJ7rqtsnmABY4/a58bRuAMhqnKYFeSF7JDtjI+DjXYhE9ttG7eUNChN2gakMkiU53J05zxbbJj8nZURkT7WdbIRy6Ucq0oz7qUuNqW3TmlRn3XxohYHu8fhf57miJ02eFqT2lVHWHsSwOkLGk6VOZDPttMYk3b2cObeD1h7KzCJPSj8aIUyqbfr1XphBxR6qi7YYVTWDQs13Q+LvhBHB5oH7RjJHgdbGU7+NT80DFj0z+EhC2r/LqZ5Hp2F3jzcK2EnXrL4xxsg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=HANtimJu; dkim-atps=neutral; spf=pass (client-ip=47.90.199.10; helo=out199-10.us.a.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=HANtimJu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=47.90.199.10; helo=out199-10.us.a.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out199-10.us.a.mail.aliyun.com (out199-10.us.a.mail.aliyun.com [47.90.199.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fw8bG2V0zz2ySS
	for <linux-erofs@lists.ozlabs.org>; Wed, 15 Apr 2026 02:18:32 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1776183487; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=aRCg1Ohq04OYnRp+wabVrBC782Swic30XU0PY1//jLQ=;
	b=HANtimJu5xkKuM4HK8wcYlnuD9TICroA3WrzcjUOt2AAD5Wnb92PutWBp71C2Yrt6IbUXPZ2fVXR4c254ZXo9xmA/jCQ13EMucbE4zoSFf0aD4yEhJvOt15DAhxnG0cgxnBvcy0yZxM7sGAzfARF6yMiUOtSID6xc42QWBP9yuM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R761e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0X11tIPm_1776183485;
Received: from 30.41.54.139(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X11tIPm_1776183485 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 15 Apr 2026 00:18:06 +0800
Message-ID: <9599562c-fcc8-4990-99e6-85b6db2f5c7b@linux.alibaba.com>
Date: Wed, 15 Apr 2026 00:18:04 +0800
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: validate nameoff for all dirents in
 erofs_fill_dentries()
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Junrui Luo <moonafterrain@outlook.com>
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>,
 Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
 Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
 Sandeep Dhavale <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>,
 Chunhai Guo <guochunhai@vivo.com>, Miao Xie <miaoxie@huawei.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <SYBPR01MB78819C794EC3532E5E7FCB3CAF252@SYBPR01MB7881.ausprd01.prod.outlook.com>
 <d373198b-d32a-49f4-9044-63c7b474f2ea@linux.alibaba.com>
In-Reply-To: <d373198b-d32a-49f4-9044-63c7b474f2ea@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-9.20 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS(0.00)[m:moonafterrain@outlook.com,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:danisjiang@gmail.com,m:xiang@kernel.org,m:chao@kernel.org,m:zbestahu@gmail.com,m:jefflexu@linux.alibaba.com,m:dhavale@google.com,m:lihongbo22@huawei.com,m:guochunhai@vivo.com,m:miaoxie@huawei.com,m:gregkh@linuxfoundation.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-3300-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[lists.ozlabs.org,vger.kernel.org,gmail.com,kernel.org,linux.alibaba.com,google.com,huawei.com,vivo.com,linuxfoundation.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,outlook.com:email]
X-Rspamd-Queue-Id: 279693FC739
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/4/15 00:00, Gao Xiang wrote:
> Hi Junrui,
> 
> On 2026/4/14 23:20, Junrui Luo wrote:
>> erofs_readdir() validates de[0].nameoff before calling
>> erofs_fill_dentries(), but subsequent dirents are used without
>> validation. The loop computes `maxsize - nameoff` as an unsigned int
>> to bound strnlen().
> 
> The issue is true, but I don't think the description is valid.
> 
> I think what we missed is to check the last dirent nameoff vs
> maxsize.
> 
> BTW, please don't "To" too many people (especially Miao Xie
> and Greg), basically I think you only need to post to people
> according to `./checkpoint.pl` but leave indivudual person
> into "Cc" instead.
> 
>>
>> If a crafted EROFS image has a dirent with nameoff >= maxsize, the
>> subtraction underflows, causing strnlen() to read past the block
>> buffer.
>>
>> Fix by validating each entry's nameoff at the top of the loop: it
>> must be >= nameoff0 and <= maxsize.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 3aa8ec716e52 ("staging: erofs: add directory operations")
>> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
>> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
>> ---
>>   fs/erofs/dir.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
>> index e5132575b9d3..2efa16fa162f 100644
>> --- a/fs/erofs/dir.c
>> +++ b/fs/erofs/dir.c
>> @@ -19,6 +19,13 @@ static int erofs_fill_dentries(struct inode *dir, struct dir_context *ctx,
>>           const char *de_name = (char *)dentry_blk + nameoff;
>>           unsigned int de_namelen;
>> +        if (nameoff < nameoff0 || nameoff > maxsize) {
>> +            erofs_err(dir->i_sb, "bogus dirent @ nid %llu",
>> +                  EROFS_I(dir)->nid);
>> +            DBG_BUGON(1);
>> +            return -EFSCORRUPTED;
>> +        }
> 
> I think the only thing we need is the following diff:
> 
> [The reason why nameoff < nameoff0 is unneeded, since
>   `de_namelen > EROFS_NAME_LEN` ensures the nameoff delta
>   won't be negative (so nameoff will increase.)
> 
>   and `nameoff + de_namelen > maxsize` implies
>   `nameoff > maxsize` so `nameoff > maxsize` is unneeded too.]

A even better diff is as below:

diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
index e5132575b9d3..2b8375c7d523 100644
--- a/fs/erofs/dir.c
+++ b/fs/erofs/dir.c
@@ -19,20 +19,18 @@ static int erofs_fill_dentries(struct inode *dir, struct dir_context *ctx,
  		const char *de_name = (char *)dentry_blk + nameoff;
  		unsigned int de_namelen;

-		/* the last dirent in the block? */
-		if (de + 1 >= end)
-			de_namelen = strnlen(de_name, maxsize - nameoff);
-		else
+		/* non-trailing dirent in the directory block? */
+		if (de + 1 < end)
  			de_namelen = le16_to_cpu(de[1].nameoff) - nameoff;
+		else if (maxsize <= nameoff)
+			goto err_bogus;
+		else
+			de_namelen = strnlen(de_name, maxsize - nameoff);

  		/* a corrupted entry is found */
-		if (nameoff + de_namelen > maxsize ||
-		    de_namelen > EROFS_NAME_LEN) {
-			erofs_err(dir->i_sb, "bogus dirent @ nid %llu",
-				  EROFS_I(dir)->nid);
-			DBG_BUGON(1);
-			return -EFSCORRUPTED;
-		}
+		if (!clamp(de_namelen, 1, EROFS_NAME_LEN) ||
+		    nameoff + de_namelen > maxsize)
+			goto err_bogus;

  		if (!dir_emit(ctx, de_name, de_namelen,
  			      erofs_nid_to_ino64(EROFS_SB(dir->i_sb),
@@ -42,6 +40,10 @@ static int erofs_fill_dentries(struct inode *dir, struct dir_context *ctx,
  		ctx->pos += sizeof(struct erofs_dirent);
  	}
  	return 0;
+err_bogus:
+	erofs_err(dir->i_sb, "bogus dirent @ nid %llu", EROFS_I(dir)->nid);
+	DBG_BUGON(1);
+	return -EFSCORRUPTED;
  }

  static int erofs_readdir(struct file *f, struct dir_context *ctx)

