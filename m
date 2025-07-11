Return-Path: <linux-erofs+bounces-595-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 180B8B02589
	for <lists+linux-erofs@lfdr.de>; Fri, 11 Jul 2025 22:00:57 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bf2df4yZbz2ys0;
	Sat, 12 Jul 2025 06:00:54 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::234"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752264054;
	cv=none; b=LMDkavZwD9krRiCoHqS/yy0NxJ3W/plt1czkGvMTr/ZhzHw4mAxq1V30Q91pXgE2rFl5/AwSmIWXblUS/LQTZoNcRTx3y6go+xUN1TqB/ZmVx3PRhztwEuzmFOjAkUmxx/y4OOxFlPpUvGh9B9BKSjzadplHJH8GrnWkfp5Xo8zos+/LkL0p8kdanP9PCOqk48VsfEjCp4wgBWOlRNiTzBjycq3Obx6IBq+kITJhmwdDK58xTn9Dd0y3fRSvYHTa6Kog81T82UjUrpFQArWcjTrXW9aAh0JkHTSx7puHr1tlJmDFjuQYyC2hfOqc1+vl+wnYedTBzGEaqz4WRpJGoA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752264054; c=relaxed/relaxed;
	bh=BaPssrD9mmgx74x6ANGtLMEUM1HaOzdpq8QOktdFIuI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NQU86FBGLe4amW0rLGbiq21BLEMmFBxC4B/Qg5VJ++6XnU2E9r++MwhScHbnEy9k/oYDeeENtlJqjDSJbmjl1MbEDCi15lrAN6ob4CaWFtgZ0ZjOaZIV//c3FPfw4pX7JpqigRz9qnKhXQBK6BIfdRa3/+vptvw98PR7yzveh/nSOfaPuRjYc0UfoLYT3qeVZfyDkz+bJoW5t3O661taEISoAAt7NOki2Bmj9RE4UG/dJQ3HwVM7zZd+mhMosFSGjSl6RHRg7QWJaOJkwOIxewN3QiGl/P86fP2jZF6i58b7fA3bomPCvgYzsZG+y9SZwaJe2rd+KTjPZx0xm/rprg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=konsulko.com; dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=NpFJ+703; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::234; helo=mail-oi1-x234.google.com; envelope-from=trini@konsulko.com; receiver=lists.ozlabs.org) smtp.mailfrom=konsulko.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=NpFJ+703;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=konsulko.com (client-ip=2607:f8b0:4864:20::234; helo=mail-oi1-x234.google.com; envelope-from=trini@konsulko.com; receiver=lists.ozlabs.org)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bf2dc5P8Zz2ym2
	for <linux-erofs@lists.ozlabs.org>; Sat, 12 Jul 2025 06:00:52 +1000 (AEST)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-40a8013d961so667181b6e.0
        for <linux-erofs@lists.ozlabs.org>; Fri, 11 Jul 2025 13:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1752264049; x=1752868849; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BaPssrD9mmgx74x6ANGtLMEUM1HaOzdpq8QOktdFIuI=;
        b=NpFJ+703jkfyTO0mb9OPNisN6m7Wd4iR92X4hSDIynXGqpnBLjdKsnfmq9KIz2Yyuu
         VGv5o2RnCEArr1wsFrpv6qcFpaQ0bMZmgus4kuAEjIzh9jzyJfOiXGik5r+ZSGjgR2t0
         le5iklZNIZqrtXfm0W1a9ipo9C70EsKSpwE9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752264049; x=1752868849;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BaPssrD9mmgx74x6ANGtLMEUM1HaOzdpq8QOktdFIuI=;
        b=LWSuQRhKKD0dsJrIV4UQNSJs7Sb/7Om6jVVsXwKu/lLKbAlmySylSr0l+eEIO8eeoN
         4qFyKGy969gxTQJYz1RXW2QW0Wi1cLybCgT79iqcKJZRf8C4+/NxNCmZpuwxMYten2lF
         fNYXXD22T9/bGkD08VFFeYgKr6a46k+4+6MrWHvkEM9N1pK3ZXbXTPjr6eTjsEDvRz/c
         eVK2LSCymVcr0bDwK4FON94/Swm9lfITiwoz6+LRKow+7qWa8Ne29mdJ1gjp3f4c4AUz
         AdggstNf6F3p/zX8is6GthVvZYR0z70i3gpgbosq5sXd8PvoonbPmgAjb05vqqp7czGb
         cy1w==
X-Gm-Message-State: AOJu0YwKJkBRRiIpvdwPXWbZgXTl/3pRj9jUan5xIMKs1O+gygjsx3IY
	4eryX5pbpNIpWJxxEtL4jPd321ZpQcdxPSyNWwkSAg3THZ/4RXIfZBuFbERyNX5p8D8=
X-Gm-Gg: ASbGncvoNCjjONNSRinNiHMC3PU9nRxyyG+LmHCAdcKHr5zej+EDq2WvMCyKibQ1GDF
	gRoNxvuL+C90hZsEPbXgkSbf9WL/RR5msKgJx+y54r5mFBiLSYmUDerqna2znU+TAFm3J5+e7Ka
	7YGJ6x66STxN1qzQZDvfDpCoa/22Uu8nF+UtCwEXPo7KNtxdWXH4GI2GLqvZorjNJ1Q4242OTeT
	Nzf+p/uQn5Ut8NJGNl2A14smXWNgaIJaD05nbZzQ4pjSzow9QmLB6PNUD2rCNgV8V3P0oB9/Fwe
	cFxFOcSFWPKagpbFhspTwzUnZi+SLNSnR3sZuEkTm5SMuvwDzPsniCki6Dh25F2uPAePVDPgQLu
	LTE1Yui1MwOtuk4oAVlSGIUHkSIInigSiVhYC1D3Xa95Z4XQImCzIokQ=
X-Google-Smtp-Source: AGHT+IF1+rcAuenvmjgp5oVSqQX900e5dYT1EFkO2wKwcoCzIX/yg6qG+GZ6Qz9eRvgTsbFkCMTvdQ==
X-Received: by 2002:a05:6808:6b96:b0:40a:bcbf:2d83 with SMTP id 5614622812f47-41511c00a0dmr3698524b6e.28.1752264049329;
        Fri, 11 Jul 2025 13:00:49 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-414161e2b74sm666516b6e.0.2025.07.11.13.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 13:00:48 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Huang Jianan <jnhuang95@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: linux-erofs@lists.ozlabs.org, u-boot@lists.denx.de
In-Reply-To: <20250704-erofs_fix-v1-1-956be16f32e9@linaro.org>
References: <20250704-erofs_fix-v1-1-956be16f32e9@linaro.org>
Subject: Re: [PATCH] fs: erofs: Do NULL check before dereferencing pointer
Message-Id: <175226404820.2365211.17225429153023348856.b4-ty@konsulko.com>
Date: Fri, 11 Jul 2025 14:00:48 -0600
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Fri, 04 Jul 2025 11:53:18 +0100, Andrew Goodbody wrote:

> The assignments to sect and off use the pointer from ctxt.cur_dev but
> that has not been NULL checked before this is done. So instead move the
> assignments after the NULL check.
> 
> This issue found by Smatch
> 
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] fs: erofs: Do NULL check before dereferencing pointer
      commit: ff8a41ce4947c6d7f1826990d5d7b96d30928e3f
-- 
Tom



