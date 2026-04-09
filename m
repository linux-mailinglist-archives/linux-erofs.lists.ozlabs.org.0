Return-Path: <linux-erofs+bounces-3237-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPSQJlV312nTOAgAu9opvQ
	(envelope-from <linux-erofs+bounces-3237-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 09 Apr 2026 11:54:29 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A85E53C8C12
	for <lists+linux-erofs@lfdr.de>; Thu, 09 Apr 2026 11:54:28 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4frwJK1L8Hz2yL8;
	Thu, 09 Apr 2026 19:54:25 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::429" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775728465;
	cv=pass; b=SfRr23vedauqnq5bHz8CRdIV2CNyEsTMCdinqlNFVRwGAjEaTT7N1SHkpYIFiJ92ZREDYdGcPXJcLEKTxlQbsQI4okFX+u4cALdSDhOdiVTvZh64FSyKXbOXvduGHen51NWlumDb/wWPfgrvp2D0yqpzzIk0HKwLVvT1NHrevAZUkdXf5OcUWupeLcoxjOg6rxHvcrrW8iB9lHMfFG7+h1IjsvOWRsPQI3naepAgpb/nHITMjVPwcNIdEIXX6/t7FxPoR6Ygo5sxzlwoY7vCsEVWnR9a5xfiIIyLgmxTCqs2GexVYHv5qv15twa71Wsvyw2u0QFTN/9ABDM7NWmbQg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775728465; c=relaxed/relaxed;
	bh=/Mw6Sm0IFQDw8/MwW4Y0PfCje9xGM9IaV16gbVob0N4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VObfIiIKej35QRFxwOSuXa45buxYJTdYHZYRMZzGWB4BbB129k0H30BaZmO9TWYH84TR4VVyi/FoFDJYqzb78LUDo7ZYQPIjdiHJ01R1hA7mK8xFS+GyDsUrX1SK+2EiJarEtnUb+Z65Gm2QDftSxejD7+0KHpQu03+GggxuCqu1ean7+4J+2SbaHFuvCztYYuaEEpRMvYCFGd2VeHiwASSIHqVDcciSAQDkn3qtOxqEnaUWjddNnrRZnuFk3f2bBZmCdg2k8+ex3nk83wd+BkvyFBLzsgIih3ZkF6E66guzTlRBjum5uoz+ykjs/9345RTkrslzy90fA1Erk9l1+w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SVKS/xlR; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::429; helo=mail-wr1-x429.google.com; envelope-from=newajay.11r@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SVKS/xlR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::429; helo=mail-wr1-x429.google.com; envelope-from=newajay.11r@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4frwJJ10w0z2ySS
	for <linux-erofs@lists.ozlabs.org>; Thu, 09 Apr 2026 19:54:24 +1000 (AEST)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-43cff5dafc3so477003f8f.1
        for <linux-erofs@lists.ozlabs.org>; Thu, 09 Apr 2026 02:54:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775728461; cv=none;
        d=google.com; s=arc-20240605;
        b=awfCBYyAyAVwewaqwV2KPeAjIvDZHZlEid4F33dLg8RFLeajEOQcBxuCN6rQYKqkha
         7244GIbYaT9XXxb5cbXtvuFJnK+7qMu0/2cb/1zSm0UfS3Guc9128am0jMH+hbeDgePq
         wkJA+2h1lB/ey0d0B+orGl/OGDhvc4kW/ozf4jlrH38MOp8WBftzazz+Bv+QuyNpWdmG
         2CBWC/G8mA6SdLmbbeowwc4jhMbh/1jcRCEGVtk9AYNrYoTC9ryQRvcjmJgqxO22effD
         YZ2MNnkfnihIU9CvQg4gssQ1KHpbgWDnSlIPKAqE3QkU5VlrISt7zdL/3kKEWROTVur3
         iPNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=/Mw6Sm0IFQDw8/MwW4Y0PfCje9xGM9IaV16gbVob0N4=;
        fh=WJhIciIiNZdDmLC1ZQ8ngNos9wKcoX5v3UjHHDA3Xes=;
        b=E27NHzIn8FKj5YRL1rOsxt3Jz8uKLpPvOyMl0r6ymE2rEb6wJlRSNZCw0eSPePwpC0
         xO+tk9tLA+cMpLOcMfISmwSeOc7GPQ2u2TKIHPWHMQ65z4pprTBbYpiskZH1FpTqCNrW
         2POzNZEPdmTUWGyx1b4MNP3mWmCbtUDWFc2NiaN+GoeB+Izw6F1ILZr5fJFBt11QwY/+
         zbgK7iMovfDKts4behr9NWe9GYm/lNu2vf0q+nMQfaBOyZIgeaRbS2g45rfagBEaOV4c
         ptdihSQxTA8v4EN0Jf054WCnzRctxYA44AFHSOvzvWbMJlAS2jcBHxdfqlqr0NqwNfSb
         wkqg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775728461; x=1776333261; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/Mw6Sm0IFQDw8/MwW4Y0PfCje9xGM9IaV16gbVob0N4=;
        b=SVKS/xlR7dij3eF8ym324DOKxMytp7kQR1ZimL0NzuV1MoKDrCk+uLYvCjme4SVOqK
         nWfc8jmYOTMbD0p6uXsez28i7pXRyzaMl4rXNsLVZSpo/tAkBmDx52bkBRo1OL6xJNsT
         NESvku+ofNYLgBuiq9vbEfbHtKvU1u+bZG9zZIjPo7tqp/BqrzrPJkjAXt00CoQ8rMVr
         bgbbudzBUNyVKsIbbyZzhRNUUZ2Hp8NLZRU2EplFDaaoYyfAD9xj7lu8V8wvdr3imlcg
         IMY9CuDTVkPDbBYM58JmpvrrYseCAi4qS67QsxgXgyOD6ySpCTH6PZ0oTkqKr/Wa1WQQ
         uvUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775728461; x=1776333261;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Mw6Sm0IFQDw8/MwW4Y0PfCje9xGM9IaV16gbVob0N4=;
        b=sjrLIIJnzGaAjWy3/La6kUR5prT+lYkyqeyqTm+kJuHtcHS3WBvSEuO5In9AA2T/cU
         55MZgafieOhHQlMLqer03aX1AUNo+KKVo1QszsBTHHLw53EquIPxcqh0jfhlUdkew5c4
         oCyyaP+oZMBozfgv+VBq+jXuibdQYOYuzDlPKUJyC9NmKjZ+bqJ7Tlw318nGjhTu0ZXk
         6pRB3DvRT5LLQl6+XrIbrVWdzp3E3TKRI7aCEp3KL/maYkUcsldUSpOR9ElmsFRlCnmZ
         eMQuqCx9JcuKnLbmCAYjxS9cysDpCCcrw7R/iM3ko0PuPx+22PnggGtC44c/ZKQuABRW
         WmDA==
X-Gm-Message-State: AOJu0YzHH1fdmyiXVWnGQjq2TyIyuuBuVrCgGimowDmv3CVGZH+DXJyB
	it2QTru/lfDDCpXQJcJjR852KpnW24CewjzTHGJJgrw1K1PTNlnnxl5KNzxWSMlfocFjL7ELlbz
	F/RwtfmIFV7fVFiq+eXRwU183a8TMVflWEEv3
X-Gm-Gg: AeBDietah0LYrAoLJNAeatAkdiNdaM/qJwzpCd4OsaihFcADzK7wI2t1wgQf1u8B7IP
	zBb7oU0SBPfVXkiib5m9iYnThaQQcy3X3AKr4srU8V2B1v/QebJHTvBY/s2mo1bd+ow7Tuvl/9G
	rOo0/Sb1b1y2+akc7Bj/ckeXKAQ971pyVFIHFhICFQRKlfp9NMEcsojiktUmTYgCWELuT7GpUFJ
	d0bo50SLvIOvX5k6YrRYqsmFlLQeDIp3P3k/+q/YX5rdZgqw9q+wCs/v5hGoy9WWsX4ZnbQFxW3
	UP1fE1gR89KC0Z+XZdh5PbfynRJg182QoblhrF+n5hNCfhyxYaGb
X-Received: by 2002:a05:6000:611:b0:439:b4dc:1e1e with SMTP id
 ffacd0b85a97d-43d292c75a2mr37207145f8f.29.1775728460985; Thu, 09 Apr 2026
 02:54:20 -0700 (PDT)
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
References: <20260409084834.147-1-newajay.11r@gmail.com> <20260409090713.51262-1-nithurshen.dev@gmail.com>
 <13c30e4c-43de-40f2-b8f4-fc8787f1f642@linux.alibaba.com>
In-Reply-To: <13c30e4c-43de-40f2-b8f4-fc8787f1f642@linux.alibaba.com>
From: Ajay Rajera <newajay.11r@gmail.com>
Date: Thu, 9 Apr 2026 15:24:08 +0530
X-Gm-Features: AQROBzCWTRmTlOw1IJQTB0xa95w6PDH_mmzC0eDxUQ8PPY4-oMSWY9Gq9ya1E8I
Message-ID: <CAMhhD9haGAtG5RVgb1sAwqqojAvG1O6J5z4vevhKmd8DyBdAOg@mail.gmail.com>
Subject: Re: [PATCH] erofs-utils: support --blobdev with block map
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[newajay11r@gmail.com,linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-3237-lists,linux-erofs=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[newajay11r@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,alibaba.com:email]
X-Rspamd-Queue-Id: A85E53C8C12
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Okay sir, I got it.

Thanks,
Ajay Rajera

On Thu, 9 Apr 2026 at 14:39, Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>
>
>
> On 2026/4/9 17:07, Nithurshen wrote:
> > Hi Ajay,
> >
> > Thanks for looking into this, but this patch is redundant. I already
> > addressed this exact TODO item last month.
> >
> > My initial patch was sent on March 7th. After discussing the
> > implementation with the maintainers, specifically addressing Yifan
> > Zhao's feedback regarding the 32-bit address limits for block map
> > entries and the necessary fix to reset m_deviceid in erofs_map_dev(),
> > I submitted a finalized v2 on March 9th.
> >
> > Additionally, following Gao Xiang's guidance, I have already written
> > and submitted the corresponding test case to theexperimental-tests
> > branch as of March 19th.
> >
> > I strongly suggest checking the recent mailing list archives or the
> > pending patch queue before picking up a TODO item to avoid stepping
> > on ongoing work and duplicating effort.
>
> I really think you guys don't focus on the random stuff: this
> TODO really has low priority.
>
> Thanks,
> Gao Xiang
>
> >
> > Regards,
> > Nithurshen
>

