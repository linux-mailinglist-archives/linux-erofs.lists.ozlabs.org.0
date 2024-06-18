Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A23E90D627
	for <lists+linux-erofs@lfdr.de>; Tue, 18 Jun 2024 16:53:38 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=H0faZ82x;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4W3VB66rkJz3cHP
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Jun 2024 00:53:34 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=H0faZ82x;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=konsulko.com (client-ip=2001:4860:4864:20::2e; helo=mail-oa1-x2e.google.com; envelope-from=trini@konsulko.com; receiver=lists.ozlabs.org)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4W3V9z3m9Cz30Tx
	for <linux-erofs@lists.ozlabs.org>; Wed, 19 Jun 2024 00:53:26 +1000 (AEST)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-2506fc3a6cfso2659146fac.2
        for <linux-erofs@lists.ozlabs.org>; Tue, 18 Jun 2024 07:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1718722402; x=1719327202; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n2OC9RzETJv83d6Z5zVnWyUBnCIMmyYOCCOt7NeESio=;
        b=H0faZ82x5XldMHGpIOvowKpabP+4Zkq9jSH5eYzfmVvbzM/0JPrRwE2MOPDVS8CpMy
         SHDrOPZLjFVpDEBHvwmwQQFcgoWNSoDtJEzyGNivCjtOHXJto8b96ptsT0gOCzFk6Kcr
         KI0AdDBboJGYW+NckWDkOKdxs9sMayHro3dpc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718722402; x=1719327202;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n2OC9RzETJv83d6Z5zVnWyUBnCIMmyYOCCOt7NeESio=;
        b=k5lhVBdNH5P1OzqbPQ4dxxX1hIM6NGrPovVMrgsNvgmFiU3SB/nTUw/HBda+goP8WN
         qNBycVlouUKY5J1hi1T9a6YKUEpGMINcvys1aPIt3XYXvyeO4wW6OBHa2mbaGckxJXVA
         Kpa1BMqRtokd3whhizV7wF6GCYNKtcYZVqnPCJEDV8+IQ4qseSgQpKLTfM7u++6U0rXG
         qpySVxM3JnigS7xMgWlu9k2gsLByxHZq2RkpuWeQGYWoVF/nilzAZpnAyTcPOk/b+TkP
         N3AP+bEzaUNXVWs432xNq9DoUlJNqnuksxunlUE7QI9/u64U7KIHufEVaCFZ15CiIRGE
         KjFw==
X-Gm-Message-State: AOJu0Yy89RjSGImj2oEebNXM2xDYuhLJMMp+Y/si31xNPNKBT8elBvYI
	YE2hDkF+iBIYaLAOw4f5imSp566B+YebXU227p8QEzfobWdk4oLSkYNIA6Pg91w=
X-Google-Smtp-Source: AGHT+IG5T0iVvue4437L7FDGIe0RYvEAFtaUwpBAXOKBoSgFkGD0HCSfFi09XDaGnlWPGxONRSW86w==
X-Received: by 2002:a05:6870:c10d:b0:24f:cddc:ccff with SMTP id 586e51a60fabf-25c94999cecmr15427fac.21.1718722402198;
        Tue, 18 Jun 2024 07:53:22 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-45.totalplay.net. [187.190.205.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2567a94b7besm3202888fac.6.2024.06.18.07.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 07:53:21 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Jianan Huang <jnhuang95@gmail.com>
In-Reply-To: <20240605140554.1883-1-jnhuang95@gmail.com>
References: <20240605140554.1883-1-jnhuang95@gmail.com>
Subject: Re: [PATCH] fs/erofs: fix an overflow issue of unmapped extents
Message-Id: <171872240148.3307069.8693215570388652862.b4-ty@konsulko.com>
Date: Tue, 18 Jun 2024 08:53:21 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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
Cc: hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org, wjq.sec@gmail.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, 05 Jun 2024 14:05:54 +0000, Jianan Huang wrote:

> Here the size should be `length - skip`, otherwise it could cause
> the destination buffer overflow.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


