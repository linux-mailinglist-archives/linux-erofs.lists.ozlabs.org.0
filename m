Return-Path: <linux-erofs+bounces-2388-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMi6Li+AnWk/QQQAu9opvQ
	(envelope-from <linux-erofs+bounces-2388-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 24 Feb 2026 11:40:47 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59689185861
	for <lists+linux-erofs@lfdr.de>; Tue, 24 Feb 2026 11:40:46 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fKvQ34zK4z3cN6;
	Tue, 24 Feb 2026 21:40:43 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.205.221.239
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771746636;
	cv=none; b=gijHWAfpXIgfPf2rB3zM4LNQNx6HO/Fa3uVX7KTIy1erq3WCrEs6gQGqmbEDh152svNwXGudm0GN0jc+WYVS1xstmhrYZQPaom61e7zj5x7EZN20/iaSJ4BnujDdmiB2YgNs6Fj3lEeG259YA6XIEt2Z0ORIkX+WitvtspsI++XRHjJG99z8UUFPW6MXB0smkFyfKdPJqYRNgkp3YNsWo6TeQP+todHkeuk6wvheiNt2OA6ZDcwOdag91yGStc7zEmwbFpLA2kzv56bviNQiA42fZ/Tndq8dKhmlX9TAfEvm5xkDsOJ+T/TpWQXHc4Yw4ghJiCD9oyk0QS6opC830Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771746636; c=relaxed/relaxed;
	bh=omUiK2sjx817pGAioh8woPCCcA/lSjegZc3EYWs64Xo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UdRKBsoJE9Jn5Yz9SLmQQ6b/7DjawWo8u3gxT0ZUTsa4/9JkcPphl2CZURtnA2ASYURukuDfi6VcLScDp0uERC9X8fa+MVjtFELwHLo2efFyCvk8+UjCNJ0PE1xJPVBVUt7SIl0tcWwqQPLSUPEx/L5qVex9Bouh3Se/SbR82YxF2UJCiEk4bSNMoFe86PKqGkvYdzYSr233iyhZ0LxgucNa/fcakxg5T+tKVSGKZwiN3yGES7OuuROQQC3gXH+Z02xV9Nb/qFTvVV/l93OlFuK3dpr6ZH7ZT1gAErcJvTMhfWL1tavgbiJ5GIvfpjwWYj6ANAuVeYUeW/Q364AwzA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; dkim=pass (1024-bit key; unprotected) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=L56TYD2D; dkim-atps=neutral; spf=pass (client-ip=203.205.221.239; helo=out203-205-221-239.mail.qq.com; envelope-from=yifan.yfzhao@foxmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=foxmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=L56TYD2D;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=foxmail.com (client-ip=203.205.221.239; helo=out203-205-221-239.mail.qq.com; envelope-from=yifan.yfzhao@foxmail.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 1690 seconds by postgrey-1.37 at boromir; Sun, 22 Feb 2026 18:50:32 AEDT
Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com [203.205.221.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with UTF8SMTPS id 4fJbkc5ztcz2xm5
	for <linux-erofs@lists.ozlabs.org>; Sun, 22 Feb 2026 18:50:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1771746627;
	bh=omUiK2sjx817pGAioh8woPCCcA/lSjegZc3EYWs64Xo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=L56TYD2DdT6RUU37iH8ZD7JvlNuh0blctZSnhnjztCkh1iIqAzPej9q97CWboQ52r
	 KwW5XbbtcxlECUekSwVsA0LqzxrOZ41Fde28Y/iB/iOpzj1TTAjVS984OeUEsuvcCL
	 p7xeXDDRF+Sws1ycZKKuE/HwYnfsxE9pSBCS9xHA=
Received: from [192.168.0.104] ([49.84.89.18])
	by newxmesmtplogicsvrszc41-0.qq.com (NewEsmtp) with SMTP
	id 4B68029C; Sun, 22 Feb 2026 15:18:54 +0800
X-QQ-mid: xmsmtpt1771744734tv2fvn3kr
Message-ID: <tencent_1678AFFD6EC67E757579937EE239D055A205@qq.com>
X-QQ-XMAILINFO: MyzM/wvJS/65buLwL+xXtryGughKQcHqAm5Q78o4q/b3FVcumAmWNZLbN7srdb
	 4L3afpBRUgOT0MoWpD8cTcEHT7ImMaqpGWaGZxPg2zH5d7Qmcp10GakncUXrJR42MbfDqskrBGF7
	 4cuhTyCMaimS6ybqTfqoT3ZynSEgm+eI9GiZZQWWwL6KmEzcnhHhHbZAifGlnYJZLHxmGmiTAaoh
	 OsXS0Npqh8B8rggkrGCzc8VHHFOWF4JdV2OgYcq5R54wTp4icHHb/4LsvG1dlBH7rzfWTecQP6As
	 Ws9zDgffyPF+70ruCuwKErqhQYcHlhss4L9VDuqp1cPnb1CQdeTwzXKrmxOofPUBulkvgGsMDSrJ
	 3yLyeLK3Kh9xuatRBCfcgF1ZWcjgbVKM0tYlqx5VbvyffMSIQ7IzDj+tOAexTdKHavRtenaJ8oxh
	 xiv1r6Z6Ievcv/9CnASm/1qUyvY0n9oTLmWwU3h1x2FtituIbbh0kNLjj+kWd9+sa4fvCriDVDVb
	 7uzEgp9A6YD7O78VqsfLN7kHPGVPltri3s3Q+lBy03qgyImL6+JSuXbS9yJMexVm84aft/qN+4Lr
	 Sx/y1tYwcrm3lBg/KSlpnnwdcxnKGZaA7priILnECUTBSSkSZ/hSwnw7khtK955+EBr8LceXk0m9
	 s94Ub8YwFy2md8uq2fqDhzN4oyzSVxYELJRx/q28MN+NvP9vze6tKW5X2o4p4BiaukUcNYmqLKIp
	 UX48lKNBb4VSq2FU53jWXP7EOLSy/ogBAXisz1JhpM5M6IRbFwblfpRNBe08pVjm/y7EFYMtYimb
	 DGbeS8Z9nxwyBtyki5tMV4WBb2TvOPINGAgVE022sQZytFR267PyO6+aDfDt88j3qMq+vM4Hk0zv
	 qtTfh+zbxTj8YVOO1DC51vkg77oGLx7OvZ5hT/dfFUASPakxelMr7nwbsMDUP7TPcxn+jZmiZCdM
	 C67iq25Vnr60VhkvcL43TFHbDy7UCCrmbRpul45HM=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-OQ-MSGID: <2c123334-ca6e-460e-805e-8c57a4ca385d@foxmail.com>
Date: Sun, 22 Feb 2026 15:18:54 +0800
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
Subject: Re: [PATCH] erofs-utils: lib: fix undefined behavior in zstd
 dict_size bit shift
To: Nithurshen <nithurshen@gmail.com>, linux-erofs@lists.ozlabs.org
Cc: hsiangkao@kernel.org
References: <20260222050219.27511-1-nithurshen@gmail.com>
Content-Language: en-US
From: Yifan Zhao <yifan.yfzhao@foxmail.com>
In-Reply-To: <20260222050219.27511-1-nithurshen@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: YES
X-Spam-Status: Yes, score=5.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,FREEMAIL_FROM,
	HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Report: 
	* -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at https://www.dnswl.org/, no
	*      trust
	*      [203.205.221.239 listed in list.dnswl.org]
	* -0.0 SPF_PASS SPF: sender matches SPF record
	*  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
	* -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
	*      envelope-from domain
	*  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
	*      valid
	* -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from author's
	*       domain
	* -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
	*  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail provider
	*      [yifan.yfzhao(at)foxmail.com]
	*  0.4 RDNS_DYNAMIC Delivered to internal network by host with
	*      dynamic-looking rDNS
	*  3.2 HELO_DYNAMIC_IPADDR Relay HELO'd using suspicious hostname (IP addr
	*      1)
	*  1.6 FORGED_MUA_MOZILLA Forged mail pretending to be from Mozilla
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.80 / 15.00];
	SPAM_FLAG(5.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DATE_IN_PAST(1.00)[51];
	DMARC_POLICY_ALLOW(-0.50)[foxmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[foxmail.com:s=s201512];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:nithurshen@gmail.com,m:linux-erofs@lists.ozlabs.org,m:hsiangkao@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com,lists.ozlabs.org];
	FORGED_SENDER(0.00)[yifan.yfzhao@foxmail.com,linux-erofs@lists.ozlabs.org];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-2388-lists,linux-erofs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-0.461];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yifan.yfzhao@foxmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_MUA_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	FREEMAIL_FROM(0.00)[foxmail.com];
	TAGGED_RCPT(0.00)[linux-erofs];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[foxmail.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 59689185861
X-Rspamd-Action: no action


On 2/22/2026 1:02 PM, Nithurshen wrote:
> cppcheck static analysis flags that shifting the signed 32-bit literal
> `1` by `ilog2(dict_size)` can lead to undefined behavior if the shift
> amount reaches or exceeds 31.
>
> This patch casts the literal to `1ULL` to ensure the shift operates
> safely on an unsigned 64-bit integer, preventing potential overflows
> on different architectures.
>
> Signed-off-by: Nithurshen <nithurshen@gmail.com>
> ---
>   lib/compressor_libzstd.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/lib/compressor_libzstd.c b/lib/compressor_libzstd.c
> index c475077..f47635e 100644
> --- a/lib/compressor_libzstd.c
> +++ b/lib/compressor_libzstd.c
> @@ -123,10 +123,10 @@ static int erofs_compressor_libzstd_setdictsize(struct erofs_compress *c,
>   		} else {
>   			dict_size = min_t(u32, Z_EROFS_ZSTD_MAX_DICT_SIZE,
>   					  pclustersize_max << 3);
> -			dict_size = 1 << ilog2(dict_size);
> +			dict_size = 1ULL << ilog2(dict_size);

Hi Nithurshen,


Thank you for catching this. I think using '1U' rather than '1ULL' is 
enough here and below.


Yifan Zhao

>   		}
>   	}
> -	if (dict_size != 1 << ilog2(dict_size) ||
> +	if (dict_size != 1ULL << ilog2(dict_size) ||
>   	    dict_size > Z_EROFS_ZSTD_MAX_DICT_SIZE) {
>   		erofs_err("invalid dictionary size %u", dict_size);
>   		return -EINVAL;


