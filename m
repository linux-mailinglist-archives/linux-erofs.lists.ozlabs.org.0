Return-Path: <linux-erofs+bounces-2839-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yGGtD3Jru2mIjwIAu9opvQ
	(envelope-from <linux-erofs+bounces-2839-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Mar 2026 04:20:18 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6DA2C5601
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Mar 2026 04:20:17 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fbrYB3KdNz2yZ5;
	Thu, 19 Mar 2026 14:20:14 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::b134" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773890414;
	cv=pass; b=dYwXutf1Y/JZjn8SKXyeyIYlZi4FDPCVPj9ZcxetS2THh4VB2agWUC0VvqcjFyT6jOXyEJQuQcB40EM0/qh4V2qjpuMzGL0pRFYW2ITlWuYi25tgqu2phwUR1O9NJvwxhy/PuoHacgiPQ7mkxw6aAAEyZVRPiaGbZnjm7RNNorlb6tvZaqB7qP5Lrssy+77gQ7yM1RzXksoNvbw+qcRJ85RVBQ1eYtHIhLqNShRSglEjgZR3+ny2nelHAGGxRe/pQcL7MQWLZ4xVGXGXELjBDRcPmQBIrIEP8GyMEfjFjYs9hIr7etyMFe6Hp2vcwAouvYYQJLmjvQndHwi5ol7Csg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773890414; c=relaxed/relaxed;
	bh=hvabPCKY8wXL/QS2F9ihM2Q1dO0VjEYvEUGamirr79E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FyM3Eq14Zk/d87vQXGMkNgjTpu5WjPzz6uYCfVvVEnKIwNAbO7snNpE3B8s1t0ROCqKb4ZbhsN+WWMN/lPt10PZhjlBWfBH8ueiZd77BHx9fiW7qlXzyWKsvr4KPr+HZSrEZ6W3lawvTkGRGHQE1NwEruMPWv+gEoEAJsCnD/JkoJpp9T6LxLgjskjJrDWndnfeRn++CkaoHv14An/8KgBeUuOsV64WpGOZU4KYRWtIX7fg5hQG4Xg8DkYAxc0Wttm2geTMcQIT66F3TPUT7jnTiGqaehey3zi4JWJCgWzC++wshvXAbtMAqXgdUgZsYd0LmYCU8WMSVTz1B4mJY0g==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=amgNIWEJ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::b134; helo=mail-yx1-xb134.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=amgNIWEJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::b134; helo=mail-yx1-xb134.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yx1-xb134.google.com (mail-yx1-xb134.google.com [IPv6:2607:f8b0:4864:20::b134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fbrY934fVz2xVT
	for <linux-erofs@lists.ozlabs.org>; Thu, 19 Mar 2026 14:20:13 +1100 (AEDT)
Received: by mail-yx1-xb134.google.com with SMTP id 956f58d0204a3-64ca2b32f46so508624d50.3
        for <linux-erofs@lists.ozlabs.org>; Wed, 18 Mar 2026 20:20:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773890410; cv=none;
        d=google.com; s=arc-20240605;
        b=S1odtpgOPxsBHFkPSB7VVAHrT453QsWHKK24w1AdwVGE8NMAslxyjMHempBquSmOay
         UJgW4+gmrC+MfFhnTDfRjy7tn6ddeQjlX/4fr040ctBk6D7Zk1Hv85nx+wXYSmMVvlRn
         HF0ETndcYBRCZW0ShTe4zuKehGpxf25Tveflvj94BoSI6ceGrtFQZotq5wgTllWcy8oS
         Yvlb1n+2J9U4V2ukI+vGoBMK/Qv0mqVqLfC599tDCmuRU1UJIy8lyiC0z3ziwqXyjyit
         l8lQy0tSXYFu3MkqZgf2G5yC91bRcRMV5A+0JbZsp3ee+W8+ChAsQ1weJhZroJ9On10c
         7Xtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hvabPCKY8wXL/QS2F9ihM2Q1dO0VjEYvEUGamirr79E=;
        fh=YNeGgKaLRiI9REgSs1kJQ9ee+IIo2N1DMX01qAD3/y8=;
        b=EbD4gAnx/ppsOTqEmEsa+M3CIjN9s3PpKd72JFesM3CKiCFSjssjUfci9clqZ9pxGK
         E+BDVKSS3cROYujgjzU5ppmp9L/siY7pjPgYl02dmVFNHb0D01HyMT5vOnxFm4K7wiOw
         1BwOm9s1QSuonZvQR09OxV5RWi2rZLkCnAZn3iHzh9H7m8XwbIB0Z6+asQXzSY8EPgLr
         YJW+hk/eurluZAjCmaZeT+IH7Vr3mmSAHWBu6M9b0oygjk3wSYitH9M7t0280+8Ct3Hh
         qz+CTVXgoyCc06bL02laC5wRppaQhCY8WOmgmNvr+GzYdoN6o5sMeiwl6okMg/QsIDeV
         9HfA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773890410; x=1774495210; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hvabPCKY8wXL/QS2F9ihM2Q1dO0VjEYvEUGamirr79E=;
        b=amgNIWEJhW+/bMr8w7MBgTC/1wQnmCMFZWIGyYOEX2bZZ/J0OjE15B4BojS/3PPJgQ
         ASMAsvYIo/7ahf8ecMPOq1NsU5r5gSbBQfGfXZoQlZr/2Y9yTS9Z1i8kwt5HCPkxH5Qe
         ffi+4c8WJ3mlyFtHtOGiUVpBeY7SGMMTU+p0pi0ZdWYQ4R7oHrPfLhHNf6hOef/aZ346
         oH+HNgBC1vCwWdLquwlXDzxLbxqNcHpFj6dlBXsozUQg0medRTKGMyWn5x/RnlcIMiea
         rnrt7ydzMcCVsy9GuU1p6qQF1z7nhzyZXrPYYvGCqLQeDHO4rajF5g8Q8z8ehSwK4pP1
         7S0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773890410; x=1774495210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hvabPCKY8wXL/QS2F9ihM2Q1dO0VjEYvEUGamirr79E=;
        b=qe0JS34aMH+NAiXfS4CMZDlNQXPcl6/ZuiSN79fVv669i4hXCtoBcIdC8MKifSc3di
         lhNVk1tc8mKxnsDnUlPIZIivd9UgE2GE80sIWHAgm1qMj9zo3yk6fRrdbKXlRkEDGnAq
         IbjmRjwDYQM9TmpPzRDMpjqgBGXJFjVlVb49t1dZR5HY05gnb9c72iI9REPgtBsEZo5w
         JvL2/W1U4sRLgir6jvxsDU5ClwJeGVa/qlORNawgjt994steRf47FtXEjxhUZ+ro9mja
         wuX+BYROaHQ1+SmMLnKRYDSsL3stUaPJJ+2tVvphDKp+gXMFGRCSxlPr/0+fp+ofOV7i
         sjjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWo57IjF8YnWR2UISEbnnXkGdRdrHiOgj845+oaOBhcXw7zmRtNKBMReNbDJG5FZfXAy8NkvTpYjFNjoQ==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxGzO0w7KrLgBgJS+bysaGHJiuLSk3fiRu2A+mC1bOd6ORC1Cc4
	xXnrKiozwZIAybs64ohsLpmBqjfQgUw0Oo/XbMXWxK2L8mPbW1M3iJ5ojxx6ss1WMq40sTJB/Aw
	TA1XT4nwhoMLWkH6mc8Ss6ZY2j1UVT+s=
X-Gm-Gg: ATEYQzwjY0id2etj2+EgWuVjhVtaN0Uoi3YBJpO92X3GV4HPpejtnXVaeaZgrPxiJ27
	sVRoyk/j5EX+vXH4V2aHxKOin8BIr/b47/8UANeBbd2xSzj7t7PfLcKEB3+N4TEUdt5qO+DGxeQ
	5atT4IenI5ZMWSsrnQoYT2e9DDFo88XE5yjf+YiGeYZxDxFLo3f6lhfPkgBHsiwkclsCVt99LQ3
	dcwmD/IW4376zhB93L7ykAWppt3FKbeB5WnUWzPaxlvwGCAIotz8OjHbB65R1/79F9S+/j/aOnP
	D+t1xiE=
X-Received: by 2002:a53:ccc9:0:b0:64c:c616:c356 with SMTP id
 956f58d0204a3-64e91354a60mr4198881d50.35.1773890410434; Wed, 18 Mar 2026
 20:20:10 -0700 (PDT)
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
References: <20260307062810.19862-1-nithurshen.dev@gmail.com>
 <b9387ac5-e717-4e9c-910f-5b218d177e64@huawei.com> <CANRYsKgoA9pMsDnBRnLgpY7ydYcuq8FxEhs+NCw9_p2ABjsMnA@mail.gmail.com>
 <66946454-25ab-4550-84af-53bdecac839d@linux.alibaba.com>
In-Reply-To: <66946454-25ab-4550-84af-53bdecac839d@linux.alibaba.com>
From: Nithurshen Karthikeyan <nithurshen.dev@gmail.com>
Date: Thu, 19 Mar 2026 08:49:59 +0530
X-Gm-Features: AaiRm5214bFjr9HsjT8CfPrrrd1yoiDjB1NRjpGt273Pxjnk8Ue3MlmfebkMPAI
Message-ID: <CANRYsKitVMo9hQdgHV0hHd4YsRS4KETs-hwnfHJe=nbUjgC4kA@mail.gmail.com>
Subject: Re: [PATCH] mkfs: support block map for blob devices
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Cc: "zhaoyifan (H)" <zhaoyifan28@huawei.com>, xiang@kernel.org, 
	Nithurshen Karthikeyan <nithurshen.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-0.70 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-2839-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[nithurshendev@gmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,m:zhaoyifan28@huawei.com,m:xiang@kernel.org,m:nithurshen.dev@gmail.com,m:nithurshendev@gmail.com,s:lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_FIVE(0.00)[5];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-0.813];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nithurshendev@gmail.com,linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[huawei.com,kernel.org,gmail.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,alibaba.com:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 3D6DA2C5601
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Xiang,

On Thu, Mar 12, 2026 at 5:10=E2=80=AFPM Gao Xiang <hsiangkao@linux.alibaba.=
com> wrote:

> Such test cases should be landed in experimental-tests
> instead rather than integration tests (erofsnightly).

I have sent a patch for `experimental-tests` branch adding test-028.

Thanks and Regards
Nithurshen

