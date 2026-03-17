Return-Path: <linux-erofs+bounces-2789-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKPROMoeuWmbrQEAu9opvQ
	(envelope-from <linux-erofs+bounces-2789-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Mar 2026 10:28:42 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D848F2A6B2E
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Mar 2026 10:28:40 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZmq96wr1z2yj1;
	Tue, 17 Mar 2026 20:28:37 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::f35" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773739717;
	cv=pass; b=Am6uPfZSLUk7LX3f6MtHN5QjLAW4QfdUp57QJ5I0uLtBPLDSDi6YqSkrOGV++1g5Q/jI1vcTbAjALDhAxOrEfVy+ys+YKbk9UNhIe8TTc6AYadvqyVE5JV4M3BIeliZ+Ggws9wn5PXSOiXKVBqnAOOtBWxxoMXKqNop1TMznSRuopVqI+NcL1z0+cxnxV5COc6aTXlRsqD6q7jd2NVHgrd3wjyEHqDn137nAPLh/Rt0upv8Lfjr89esHV/klb4YcQo/h06FDpdCAyJKdgH0C/d2PwXmiCEq8WJQU3yUUgt+Fs54VgROhHKiVl/1TzzLWx1cjlr5nQxfA+BylXO93Jw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773739717; c=relaxed/relaxed;
	bh=PvD8/Te19GFe3S5W8z6akZke9IFh8wtmo6rgtj4K0uY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=drqle1AWHBPX/6swhtD7NJZK6vWFn3EobcDgWgiMo7VBlgeFZRcGrOdbvIPHRWUtyz8jcgLkmLONIeetwzt3WMilLPlGDogteuAJydu+dmiJG+/K4187GXwg2E9CoX54sFrAzUeacZGlzMPKLBfnup7R+AzwWviSTTocWDtiB5hpQZOlHFt7hrGhNPiSWxzsCfsdGfWa3OA0rY2N91yGDzdLQLjj9Xg8u/oTAOApdumQpEppr1yBFsmbXXJRE4v5Tj7BmrSZkJDeS00zq/01bAqb7HdvcSMaKlyCv9EtIHzTiIQXN1HOKIsFkAsi71movgRL2TwK6NOzRyECCp2YnA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=WT3wbTP6; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::f35; helo=mail-qv1-xf35.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=WT3wbTP6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::f35; helo=mail-qv1-xf35.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZmq82hHgz2yfP
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Mar 2026 20:28:35 +1100 (AEDT)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-89c5029b5cfso3807486d6.0
        for <linux-erofs@lists.ozlabs.org>; Tue, 17 Mar 2026 02:28:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773739713; cv=none;
        d=google.com; s=arc-20240605;
        b=D/ZhO5hhIRBc0M0XgifuESdN7HfnSyKKR8snyZpSlg5Jc6vOavOTY9oOW7ciKP2WBT
         9EEIHxTOIGAbSD4ilCWh04z9CCxVHDg3hDq9RJY1ujNRjnE4BkF9fRCQCX/LPmzbA26v
         KPdvJJxDonBC94xG3YK0gLFq87EzPOytMqAgT6ypRxJRAX+R1EgP75oyAYrY7/BgsOTe
         adgrfxhtuYEZJJKbO2fPZ2KNUQk0uK3Txup1CPzb8+garzRH+O4kYVoonIaUUXocf3RB
         On13lX5QIOJIIcS9a2MbKFM3B0Be77AKx+PtqomAHiXj9UR6qX/m6act0Xgpww2/tgSv
         3rfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=PvD8/Te19GFe3S5W8z6akZke9IFh8wtmo6rgtj4K0uY=;
        fh=Ti2Ztps5ncTGufxtmxrJu908O7DsJpNW+u8nwQfRTHs=;
        b=TSmHF3Ah3asgjnBLgqanGxpFstzrKJzqCxI1NO0o/Qfk/ZZKXBZxJA9WDpwfQqtpRJ
         VUz/XeeMBHfxXwoxMAbKV+9u6dCiXeL0cUfCylhp4mmCVDnZm5pSQR06t54PgF1NwxUc
         dN4P6SGSvhSHK2NwTwQKthm/OA/L8t4PjHHv1SXL6xYnWf02XAZqhT6TSbjdDPLGceYa
         pXoztP0/yPnyNr7jAxf5e2yY0JimQvGEcOqjs4gKvgWV27oU97TLrsDPLVqvNbUNNEUh
         nVcJFS4vCyx0JGyiiWWxShNkzSW9uw74HkNpKNPBNSk25ObCZcYSvO8fQiZDPc+2pPUI
         821g==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773739713; x=1774344513; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PvD8/Te19GFe3S5W8z6akZke9IFh8wtmo6rgtj4K0uY=;
        b=WT3wbTP6MDGHnMqXvOLMtWUcuOYWQO2KktP/bsKnLd3SKg+ScssqWQoPOkN6rklcTq
         R+wykn0ci0MCmRawR3ML9KYGmUgrG4opLpXbFR7vuhWauXgia2vhaylz5nXzhRnB01yy
         RtNsCZHDdQK9cVw1DH6jVCMF+BUBAkqfH06hrW6kCbxs2XbGAw2PIbHVz6dnRkmYRpyi
         FBCY8C995M0WTsCx2of/0daFN6AR/X1Cz3UYHeWMBeAF52svT6pbIsbJMiv00RJjbkR1
         1Vqh72DImylU+VPHP1CN8vrB5/1k6gqQysonyd2UPf4P2tYWFkvKRZOHLDsdlH/TKoOd
         8m+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773739713; x=1774344513;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PvD8/Te19GFe3S5W8z6akZke9IFh8wtmo6rgtj4K0uY=;
        b=h62fVJ5aOpEiwqShtKaVDb9oWugR9txcOVM17Yrnn9K3IU5FZUQys6nWu4PAmsOBS2
         nf6ieTM7j9+bot5N4jlGs239MOGCXfMmSsHM0vlXaxE73+Aj8PYHYZLaDEqR/rnOlsZ1
         uC1Xz2Mjeh7zUK93BnaSOxOUJQkeoIF14nE12ty3KV2Pgjn3RHPnJKKErlD/wjUkNgAO
         qtacCMSo1Smv78lBxIQVTDaSGSBbW88ldDs0/lX5QBklXNqerFtPZiPYftlfDyhHV650
         hMMbPQm4sJObIbaR0mh7NSo1bYkDMVE9ngijbv1pYgRHrG6MQF24+ufKqwaHWv3R5JFU
         c+TQ==
X-Gm-Message-State: AOJu0YwWkDDJSr5npGR0J4Mf91QRYT7Mr85uy/5X8VGeqqEQkRrLGL5H
	/1Cd6oKdLemL8iA5SlGv3eCJgqlrqPY+9je6l5Jf27NYj7nYGJ6kL/em7ylJG0kLYksstYhG1nJ
	qt/1hh3fNFYxgXDmU7+Ea0lCvFf0fkcU=
X-Gm-Gg: ATEYQzwL1dEBwZaZEp2Clt47tHCl0BD7PC/tgNNXiqcREb1jD+bvhsC8u/RWRi2/XkS
	/HKdSDlZNwMcQ2NQjcDVyogNrQpu0DWJrmfOk6xbc2u4LFK3ekDQFCSAiQyvtPK99G7vsfYzpcu
	qaDvT0/KLUBWX4L9C9jRe1gComGnvI0UCwkkjbuMJMeOkAW3qWi6QoHOgMolLitPA+nBJ5EjK5H
	b4xuVVhoGPYcrVRMVO1VHAcutGQ7aZViHySYxHZmMJKZvDNZbETMt7WlNnWunoB2VY5IaJoVX8O
	tihd2hDlZPBK53TGf/dGEbv4pyxAUiAmhZW2x4O4xQ9j2YtJ6NHaRSUOTrTnVRJgTqNy
X-Received: by 2002:a05:6214:4e14:b0:89a:4449:ac0f with SMTP id
 6a1803df08f44-89a81f51a27mr164742456d6.4.1773739712632; Tue, 17 Mar 2026
 02:28:32 -0700 (PDT)
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
References: <20260317082115.34389-1-singhutkal015@gmail.com>
 <09e4e9bf-e214-4b40-8d2f-44596fd7c8e8@linux.alibaba.com> <6f30b996-51b6-403f-b343-3935b6464676@linux.alibaba.com>
In-Reply-To: <6f30b996-51b6-403f-b343-3935b6464676@linux.alibaba.com>
From: Utkal Singh <singhutkal015@gmail.com>
Date: Tue, 17 Mar 2026 14:58:25 +0530
X-Gm-Features: AaiRm52lfzb-7M3LuBgLEynkXv3IB17BaQk8lhn8cRVowy7punfDZR-tewug2YE
Message-ID: <CAGSu4WNbaUbpkR7pEsN_KEXtwTp6q_FFgnuyJkGbFC9qdjgrRA@mail.gmail.com>
Subject: Re: [PATCH] erofs-utils: lib: validate z_extents against inode size
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org, yifan.yfzhao@foxmail.com
Content-Type: multipart/alternative; boundary="0000000000007ed9d3064d34f5d9"
X-Spam-Status: No, score=0.1 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,HTML_MESSAGE,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[multipart/alternative,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2789-lists,linux-erofs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,m:yifan.yfzhao@foxmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[singhutkal015@gmail.com,linux-erofs@lists.ozlabs.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[lists.ozlabs.org,foxmail.com];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-0.998];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[singhutkal015@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Queue-Id: D848F2A6B2E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--0000000000007ed9d3064d34f5d9
Content-Type: text/plain; charset="UTF-8"

>
> Understood. Thanks for the detailed clarification.
>
> I see that large on-disk values can still be valid and that existing error
> handling (e.g., erofs_read_metabuf()) already handles boundary conditions
> appropriately.
>
> I will drop this approach and focus on identifying issues with concrete
> reproducers and clear impact under the current design.
>
> Thanks for your guidance.
>
> Utkal
>

--0000000000007ed9d3064d34f5d9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote gmail_quote_container"><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex"><p class=3D"gmail-font-claude-resp=
onse-body gmail-break-words gmail-whitespace-normal gmail-leading-[1.7]">Un=
derstood. Thanks for the detailed clarification.</p>
<p class=3D"gmail-font-claude-response-body gmail-break-words gmail-whitesp=
ace-normal gmail-leading-[1.7]">I see that large on-disk values can still b=
e valid and that existing error handling (e.g., <code class=3D"gmail-bg-tex=
t-200/5 gmail-border gmail-border-0.5 gmail-border-border-300 gmail-text-da=
nger-000 gmail-whitespace-pre-wrap gmail-rounded-[0.4rem] gmail-px-1 gmail-=
py-px gmail-text-[0.9rem]">erofs_read_metabuf()</code>) already handles bou=
ndary conditions appropriately.</p>
<p class=3D"gmail-font-claude-response-body gmail-break-words gmail-whitesp=
ace-normal gmail-leading-[1.7]">I will drop this approach and focus on iden=
tifying issues with concrete reproducers and clear impact under the current=
 design.</p>
<p class=3D"gmail-font-claude-response-body gmail-break-words gmail-whitesp=
ace-normal gmail-leading-[1.7]">Thanks for your guidance.</p>
<p class=3D"gmail-font-claude-response-body gmail-break-words gmail-whitesp=
ace-normal gmail-leading-[1.7]">Utkal</p>
</blockquote></div></div>

--0000000000007ed9d3064d34f5d9--

