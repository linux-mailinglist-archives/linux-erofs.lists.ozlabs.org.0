Return-Path: <linux-erofs+bounces-3456-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGc1AU6yDGrdkwUAu9opvQ
	(envelope-from <linux-erofs+bounces-3456-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 19 May 2026 20:56:14 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 245D7583EDB
	for <lists+linux-erofs@lfdr.de>; Tue, 19 May 2026 20:56:12 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gKkQy2yr3z2xwH;
	Wed, 20 May 2026 04:56:10 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::635" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779216970;
	cv=pass; b=lB4xyBvmfvoHCIoCJxJbv1UGo3/npTeBMCNxuDxloyGPrMlkHgv3s7UI+bkmSV87ARdTVpEjNTRwGtLgjrZarLrg2hlCri1/fQDXryV7reU1l1GGnI/8l819WnLdtsia3K78ZbYovzzonlAHYWQsNK0DDONXeVvf/ISDW7CxGZv/iMFClPUJtraIYcryv6Ikm5/GaB4XUjKvD9a8+3P38yyzeEGZI7KZsG8TuFCuXFoPsRlb8wapLd+54nv8rTKEEADLXElOWdgj801g169VSCqmJRsnFHH1GxBO1zGAtbvMBFd1bUI5XJG7xhgyx84BwABdCgyJccjn2j6UGy8qZA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779216970; c=relaxed/relaxed;
	bh=2z1MKhgSRUKCxKcMsmbZ2SKx4kIRm+/RWr8n7/BndPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KMRXN1L4hYmSFta0epDdL7Sb0kmSO4N6OPwXb51wtHnWzbCFSUnJfmTKHiXZbyJIQeqWKaIuNBp/ZyyWKXQ2OBM3gMJz0mo2Kwxg+ke7lXM/cexIApikoU3emQ2PzVwcrvZvsFhpGdrGGUG7GiiofgxuwDMgWg4hKKuaU3StKET5GreTm6uAtkLGp77G4YUb35b0P1VjOciFqW+PP//qdGqKfWXO0MdIoWUmwyk5OJ6dNXZ2fBjQuruea7zZ1Ev1vJrrx2jH24usuMIkfVwF+0JTzYY92aGtMElUKIhSemqfFzd4SGDI31VRKwGtMcyCwGr7Q02BeeI5jmdWxrUFaA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org; dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=KBLWOXbg; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::635; helo=mail-ej1-x635.google.com; envelope-from=sjg@chromium.org; receiver=lists.ozlabs.org) smtp.mailfrom=chromium.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=KBLWOXbg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=chromium.org (client-ip=2a00:1450:4864:20::635; helo=mail-ej1-x635.google.com; envelope-from=sjg@chromium.org; receiver=lists.ozlabs.org)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gKkQw5FLQz2xqv
	for <linux-erofs@lists.ozlabs.org>; Wed, 20 May 2026 04:56:07 +1000 (AEST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-bd3eb594960so500940266b.0
        for <linux-erofs@lists.ozlabs.org>; Tue, 19 May 2026 11:56:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779216964; cv=none;
        d=google.com; s=arc-20240605;
        b=OucUGoCQdKRa/OF4MAkrGNIBbEw2IsFpWCxrpFeVRua5vbKz+6gnbcyTUqx6P0n3OC
         LQ0yF4UP8r7cySLSuAic8WH3XOHaTioFRfgZGcDUtvJ2ljow4pN2vcJyur0re1QvZVqs
         UmHDepx3HgrkmRn5jcrzAukwmvR0U8WBB4mrIuX1sc2nS7M3YPDtZltcZM7mqYCCggGn
         cL3E6c+/W1pSgAzWO/KToyqRiot4ZAE3xeg6O+xclDyygDkx6YPO7taEyyrqcyY3ToT/
         +Ke2WYQqkmCHMced3F6VUEvXUkrrRq5OtIkIbAE6OktgRfK7ruot2m0hPfgSDETTxy44
         hiCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=2z1MKhgSRUKCxKcMsmbZ2SKx4kIRm+/RWr8n7/BndPg=;
        fh=WqiGR+Zsi7huz0DJ2Vj8u1v0plwzfafIHZ8DwFthqWg=;
        b=BvlmPRQswbUSBjNau57zyPcaHb++ViBXDXXuUn17w6j5UTkPTBDhXMhWpoIRgcAIns
         iucwcIR7lRc1AsfkNu63hp9UB3a9dIr9boitsTstTkazzgzqNxHSguEbU/udAVI0yJ/d
         KPYIgLeqGWtFnikD4iAFnUulhMO6HhUqqBxcABJsBij4ZBSQ74pZH4eneoKbCKyLj098
         sFvGlFoOQ1VhHIzIORnjtsgQrSfwH/eTISOSkEx4daMPqqCjeeS6c+aAfh+WNfjB8t4n
         gJd2/TEXxnBInzcS+KqW25FikWNEQvYe9KcDHIt9rbAmRz8J/L0xBVe6MQXmDqMW9Z0/
         VBbA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1779216964; x=1779821764; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2z1MKhgSRUKCxKcMsmbZ2SKx4kIRm+/RWr8n7/BndPg=;
        b=KBLWOXbg6JJximVQXTMxypZYL15/cxQ3ajfuMeA/KXN9c3XlSgnxiRUFMCQhxYOgbt
         lUpQw5furDQ/97Os2+obWaW4G0MPOwZ/vd+ZW2JYG50vwl00khK/OBDoLSCwQEc6V5Ed
         ZHEAfO72ldru2uW2j+9L4PKOVEzQrGywokf7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779216964; x=1779821764;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2z1MKhgSRUKCxKcMsmbZ2SKx4kIRm+/RWr8n7/BndPg=;
        b=jv9kliD0kna2+wSNeTIFYJwyQl4in+VqwL5CgIlAvxyJJ5HibNhdsRlH12mQBG5K9c
         X04eXISxjT4+KtgcJTGt68MdbNNqj/yfawy0FphL8nTpBu0kyS7CXnc/V/A4X/ra2P8x
         klVBynHQWdCobeuu+cQ8opF3c+rJjiD8PIA8cDju85EWepFNauTy2dBz/Q/kko+XG3va
         iIRzo5xPNyRZMefEuzVNC1POEmza5li/KFoSWrfdzxnWccHy6XLN6+NEtG1Sp7RlgMMs
         pjZOx63npxSds5AWSCmyCAU+WSrSVVllI5AADAGjO9tbk43AiWis1ld5NbymQCClDPjJ
         CHHw==
X-Forwarded-Encrypted: i=1; AFNElJ+U6RnX00GcM3JGWBQNdDQF5dS+0vI9+ReJznMUJMNj90DR6sLBvwGd2zcTpumr2yXrScVhtDth0VtajQ==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzTVF5lgqYaxEcYIuApv2rYNNWG7J2DtNMIjeEVFuVwOo+LJ38Y
	tBzq7KkQxtY+tOSoplaCufxbetmnc1hnGoT//5i8yTXTog/fEQjL++AyvwsNXy6WECqJBW8fk84
	+5xc9J+Km4qhjTaTWwXeKSJlVPPv+wQJ8BIXcU7PX
X-Gm-Gg: Acq92OG+J7Bb5/Y1Yjejsy3adMJEb5a9qNj9TlUtPdAfjFzWuxLtYFPZdJkreawac2w
	V8UlLBwJySHpgyJarxHCI8/j0dF7D9D5jI6cpwtIEu8R2R/zv7pRd3SsTm0fXTIJTI41HsV7cEk
	wE/HVZefekh6W9yAAAvm/GTYGJms4NMDn7XvFP3fxhAtIVLVzdzWt28pgSuk+OMbk1KghQkcHRK
	JwgW/pstJ2ahejZNacEE3h7sjw8VRbhptqe3oUX6vKVQpsJSJQ3osajAV3YUrfvIRliVkAQqaHY
	ROGSUh6+AN/popB3
X-Received: by 2002:a17:907:9805:b0:bd2:fcd8:4cee with SMTP id
 a640c23a62f3a-bd517aba140mr1235644666b.44.1779216964568; Tue, 19 May 2026
 11:56:04 -0700 (PDT)
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
References: <20260518055728.178507-1-heinrich.schuchardt@canonical.com> <20260518055728.178507-2-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260518055728.178507-2-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 19 May 2026 12:55:53 -0600
X-Gm-Features: AVHnY4JU2IMivRWIamc1KNpAHR181SK7mZjwVx8mH50CDtp5b4CcGP-yEetosTo
Message-ID: <CAFLszTjZjRJaLwET4SAUQ3Y=fBupo3R7BA34ei6s1aOC2=7FjA@mail.gmail.com>
Subject: Re: [PATCH 1/9] fs: move struct fstype_info definition to top of file
To: heinrich.schuchardt@canonical.com
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
	Huang Jianan <jnhuang95@gmail.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
	Tony Dinh <mibodhi@gmail.com>, =?UTF-8?Q?Timo_tp_Prei=C3=9Fl?= <t.preissl@proton.me>, 
	Francois Berder <fberder@outlook.fr>, Andrew Goodbody <andrew.goodbody@linaro.org>, 
	Daniel Palmer <daniel@thingy.jp>, 
	Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
	Sughosh Ganu <sughosh.ganu@arm.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Peng Fan <peng.fan@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de, 
	linux-erofs@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-0.70 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-3456-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[sjg@chromium.org,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_RECIPIENTS(0.00)[m:heinrich.schuchardt@canonical.com,m:trini@konsulko.com,m:sjg@chromium.org,m:jnhuang95@gmail.com,m:quentin.schulz@cherry.de,m:mibodhi@gmail.com,m:t.preissl@proton.me,m:fberder@outlook.fr,m:andrew.goodbody@linaro.org,m:daniel@thingy.jp,m:varadarajan.narayanan@oss.qualcomm.com,m:sughosh.ganu@arm.com,m:ilias.apalodimas@linaro.org,m:peng.fan@nxp.com,m:marek.vasut+renesas@mailbox.org,m:u-boot@lists.denx.de,m:linux-erofs@lists.ozlabs.org,m:marek.vasut@mailbox.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[chromium.org:+];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sjg@chromium.org,linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[konsulko.com,chromium.org,gmail.com,cherry.de,proton.me,outlook.fr,linaro.org,thingy.jp,oss.qualcomm.com,arm.com,nxp.com,mailbox.org,lists.denx.de,lists.ozlabs.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs,renesas];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,lists.ozlabs.org:rdns,lists.ozlabs.org:helo]
X-Rspamd-Queue-Id: 245D7583EDB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-05-18T05:57:19, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
> fs: move struct fstype_info definition to top of file
>
> Structure definitions should precede code using them.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>
> fs/fs.c | 86 ++++++++++++++++++++++++++++++++---------------------------------
>  1 file changed, 43 insertions(+), 43 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

