Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2658AA6BE
	for <lists+linux-erofs@lfdr.de>; Fri, 19 Apr 2024 03:58:17 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=ELoJdR7Z;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VLHqB3VqYz3cby
	for <lists+linux-erofs@lfdr.de>; Fri, 19 Apr 2024 11:58:14 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=ELoJdR7Z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=konsulko.com (client-ip=2607:f8b0:4864:20::832; helo=mail-qt1-x832.google.com; envelope-from=trini@konsulko.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VLHq169Zkz3cMX
	for <linux-erofs@lists.ozlabs.org>; Fri, 19 Apr 2024 11:58:04 +1000 (AEST)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-4365c1451d4so8072941cf.2
        for <linux-erofs@lists.ozlabs.org>; Thu, 18 Apr 2024 18:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1713491879; x=1714096679; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IFSiTIQscVIy/Xo6kH5F5feYZZbjIP/kSXDnFx09UyE=;
        b=ELoJdR7ZgOym1uBY8fXIzJIkl9HyJyL/q6vHc2TwE321DTKeZPZEnORprynEBJ8H9F
         Zvp0dORc1ofWzOn1bSBra/AQWSq4NQBE5rU6b7CKeMgHgccv9wQu8cSjTyEs/2s5rAr3
         eoB2gjqYAuxMtsKTNubnnt2qO12SWB76IVyEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713491879; x=1714096679;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IFSiTIQscVIy/Xo6kH5F5feYZZbjIP/kSXDnFx09UyE=;
        b=qAWo40O62VRrifkbqYLMGZ1pCscVVgucUeXljkw1jCFPvgvPKcQDCqzO2DekhSePM6
         5QWyKzo1lqU4AUsdhHClTBShsasyfpYzrWKJTkHPSHZyvDDUJK5us0gCDzqVQYKiNjy8
         41DvvsZxb5LR7ano52rV1WaD4J3qwlnI3LVZ4LjGRYoW+yRAhGl0YHv9o8zuU4FkeGEt
         wPoYC6rDXKW8UWGnHXtS5xfMu/7u2RIYX/GztqtXea+7Bmck+5dwAq9SfbGR4K+8DJxE
         0hvRmYc5+kp1hJusn2+jSfaV97CQj3ysDy3EQo/76ApLChbDuTOglAHMvonjUWt4mzXM
         HCBQ==
X-Gm-Message-State: AOJu0YwitMlPaeSoXLn8JzD5h43zsxNy/ZyBnuKsrjyT2Rzly/E/zh2I
	LCYsJm9D3kW13Xw25LoHakHD1L2ymCDDctyMKHzYwwFTskzSr3AI037ANOjpCIs=
X-Google-Smtp-Source: AGHT+IFnwGzIWTlUslHxEytXkDz1I10WNvJSuxNg5GZ9zGgR1Dm+/8hwyIcINq/FXuTHz1v8DXmjLA==
X-Received: by 2002:a0c:c252:0:b0:69b:20c6:a3f1 with SMTP id w18-20020a0cc252000000b0069b20c6a3f1mr684064qvh.53.1713491879582;
        Thu, 18 Apr 2024 18:57:59 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.98.216])
        by smtp.gmail.com with ESMTPSA id b4-20020a0cf044000000b0069b1e2f3074sm1167777qvl.98.2024.04.18.18.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 18:57:59 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Jianan Huang <jnhuang95@gmail.com>
In-Reply-To: <20240414150414.231027-1-jnhuang95@gmail.com>
References: <20240414150414.231027-1-jnhuang95@gmail.com>
Subject: Re: [PATCH] fs/erofs: add DEFLATE algorithm support
Message-Id: <171349187833.1524174.11798846969773429798.b4-ty@konsulko.com>
Date: Thu, 18 Apr 2024 19:57:58 -0600
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sun, 14 Apr 2024 23:04:14 +0800, Jianan Huang wrote:

> This patch adds DEFLATE compression algorithm support. It's a good choice
> to trade off between compression ratios and performance compared to LZ4.
> Alternatively, DEFLATE could be used for some specific files since EROFS
> supports multiple compression algorithms in one image.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


