Return-Path: <linux-erofs+bounces-3296-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wI9bJ2hV3mmoqgkAu9opvQ
	(envelope-from <linux-erofs+bounces-3296-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Apr 2026 16:55:36 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E82383FB82E
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Apr 2026 16:55:34 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fw6lR4J7Vz2yVL;
	Wed, 15 Apr 2026 00:55:31 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::632"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776178531;
	cv=none; b=JDNoXSJj1QIWhqoHroG4GbVvNMEpA70U6ev4Son5gdpfe5j7/8/HXu6lymLPrM8ILEQs5AS0hYLjNo9SOxLdPbbMyLdlc5/hClf7Ml3ma0ee3tuYDIlNk6CwB+LmcaNop0TSGgisscpkGxtQqokax7/+baDIlMHarJinOzibCvYzIUZrMl4f2gWhWe/t/o7bco6G98lTUdE4U917K+5BFrZvHbPHzUjGJRUVtbzYjDPmB42iYfXSY0T5ojxD68pvPw7Zkw7NEPgft2K3CvgU/Qa8N+bZTt2d8OHaYNDl1zd+wCIlRnrWB4e3dG4kRYnnGVQxprhTpCtOiKGwRY5Q4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776178531; c=relaxed/relaxed;
	bh=elO3riYJWCJ6n2G4q+8UsLTshQp8FJM8yXRjJMSmhts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fuwK205HRaR9GXybA57XKyN2EA+WFxzdnYXbUaWQpkFwIKqFjbkUVCtIUZ2tsH+Xn4uGTJHvn8nNW1WWGQK0PxNqMQMqk0FDLv537lGuUCWJCeYknUgaCeC3AIkn+XIZCdxWh6IVDNEL3Emw02gDPV/hf+jjyUoLOBw25qYaatV+/ShWT3TrD1qoi5EA8+RBt2XIUg0KFdy2YDVw5DvhtNhnBR5MTlZYgTbNUUzjgjeNaFW+jJRfIhUpLzkJyiWkC+oGg9c5HJcbW+nwAiks/X6fyk0T4eOeqSZjkvG5aE7nMCqdP833iIoKALKkoIO9Z7r4Irpxljf6k2CJlN+RhQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GeuksVrz; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=zhanxusheng1024@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GeuksVrz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=zhanxusheng1024@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fw6lQ5Nxjz2xMY
	for <linux-erofs@lists.ozlabs.org>; Wed, 15 Apr 2026 00:55:29 +1000 (AEST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-2adbfab4501so24481335ad.2
        for <linux-erofs@lists.ozlabs.org>; Tue, 14 Apr 2026 07:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776178528; x=1776783328; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=elO3riYJWCJ6n2G4q+8UsLTshQp8FJM8yXRjJMSmhts=;
        b=GeuksVrzXxQnEOxceQ+Hmp3SjGFLVREcVxt1MYkjUj5OD+EmqHFh0Elb7upObTqa/C
         G2+KrULqnQMpS16su2v7dxy74/0d6kwuUG2TLzIPRHs6vlXpdapQlaOZ/SDA0GYQKnjg
         0H77L33uuYnQKdHI+XghJifOck49jsGog50/imgJ6Bh4A4GezJtsPIvbbypBQDEU8uW7
         FyqP5aVM6hdqv/SGUBeM1KSBezVhV393SEXXahTERkpVuQJPbEXhsm2XjnytK+EouEJU
         E8BDk7DY8kvjtXmD/usYlHgJW3qsxOZJCXsw//k5HZbGEjLC5Um0G/aNpFs80HABMIYR
         j1jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776178528; x=1776783328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=elO3riYJWCJ6n2G4q+8UsLTshQp8FJM8yXRjJMSmhts=;
        b=M1QgXzYTtdXXzq6+ppIyQss2zcxhzLjPGyyXtfIhhCffexoxRvEXtoVHOahpaz9qjO
         9TrG3/ryZxo39kLO3CN11d/tmnKShY2lunvNYLj887vfTFlMZnEMscB1/SGcwbgX758a
         oSrfpiAU8G4G08PWE5B4d2XEVfQts43eAcKzEP51yow7UDALhXIe1Og43z/AJaXYlqDc
         nToWaXcSApAZh2v/yfwTl+wSLtWygR7VMnyCGObnSXwfLLDsFH8cf01VrMe3VrBvjQUD
         fQgDHHqpx5j9c1gvifzmhP6riJKQZ3fXsBGox/JxTKtiv85PDgkqNdtSTyNjRAgBRq8q
         /xXQ==
X-Gm-Message-State: AOJu0YwUNuboSTl8nam4G7ptHEFvFYJhDQhmS9liRfS79oEcrkFhJP9v
	j+WGsZBA1LPU8sPzYDtijFk/a7ZdVbtT83E7qMwgW7S2G7nj0h6LUrx/gz1Ppg==
X-Gm-Gg: AeBDies0Zsc0I4lWgF472TEkPwmDodGFQw7fVwTAnQJZKMXvEA22Qn/yH9Y59bYHeUa
	QqaROjsHLq4cNsmIsGVxM8iMQZ3ffEacRbJuRPVdWAW5+lrswItDUydyEIJfJIp2vtmQBDUox18
	KhdQ1IJWdgFXxGi+8W0Z9d//XojI9fhQyB6oKNDfgf4ETp28EiDQv3vXxlVxWNb+PncA3ZYj/Nk
	ZxZSDhxa3yyWjLLeuipEmYIHPe7H23nnyjJjPw27NQtMBOPPd5TgV4QTFWLKw60bWrZFAUmy1EW
	Tw4DC4Q79TLL7ol0ZzY/P4GewmS8nyGO8pRTdo8k49XKAIPd43iAivq6mEuP+iCVv0Be+VYk8Nw
	xeLsAGtKUFmJG3Rt76a7EVrvAcxzqLf02Ntpwg31s8BL1j+tbRf31EvnuCOJUS6y26mjZ92V2P1
	U4q7frqs22jCbC51ALA8n7yKMlWs3JOgDNj92rnb0glfQ7w5I9CSMEONdlVg==
X-Received: by 2002:a17:903:2acb:b0:2b2:50f6:cdd9 with SMTP id d9443c01a7336-2b2d59764f9mr169868075ad.8.1776178527791;
        Tue, 14 Apr 2026 07:55:27 -0700 (PDT)
Received: from DESKTOP-MOQC9AF.mioffice.cn ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4dd7faasm148848405ad.26.2026.04.14.07.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 07:55:27 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Google-Original-From: Zhan Xusheng <zhanxusheng@xiaomi.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH erofs-utils 0/2] tar: fix parsing issues for pax and GNU extensions
Date: Tue, 14 Apr 2026 22:55:25 +0800
Message-ID: <20260414145525.46972-1-zhanxusheng@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ff3c6662-c86d-474e-8672-c4cd8ce29031@linux.alibaba.com>
References: <ff3c6662-c86d-474e-8672-c4cd8ce29031@linux.alibaba.com>
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
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-1.70 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3296-lists,linux-erofs=lfdr.de];
	FORGED_SENDER(0.00)[zhanxusheng1024@gmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[zhanxusheng1024@gmail.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.993];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[xiaomi.com:mid,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: E82383FB82E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Gao,

Thanks for the reference!

I see, that looks like a similar issue. Please feel free to take over
and address them together.

Let me know if I can help with anything.

Best regards,
Zhan Xusheng

