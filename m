Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D54BD7F5ADE
	for <lists+linux-erofs@lfdr.de>; Thu, 23 Nov 2023 10:13:01 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=XeP9NvIQ;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SbXT04YNzz3d8N
	for <lists+linux-erofs@lfdr.de>; Thu, 23 Nov 2023 20:12:52 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=XeP9NvIQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52b; helo=mail-pg1-x52b.google.com; envelope-from=zbestahu@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SbXSw6x4qz3bZM
	for <linux-erofs@lists.ozlabs.org>; Thu, 23 Nov 2023 20:12:48 +1100 (AEDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-5bd33a450fdso479303a12.0
        for <linux-erofs@lists.ozlabs.org>; Thu, 23 Nov 2023 01:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700730766; x=1701335566; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NVN7Lm3QnNbj//OIUFLcvcVkFW66YIketLgRhLuAaTg=;
        b=XeP9NvIQQ5dJbgBlGahKkNV22Z+Q1s6SsD84fTNDGb3RugeZ7Tc4cOLbFVhXovDwak
         gKIsQQSUP0jiP5Ui8LlKOKi1dY4hFBsUUeN9W/Kilmg3O6yP7JVOr6GgZ5U82/9gWfD0
         NaHXtx+8g+DgIsUPB4LwY5QjMPVo/xS0pQjeR5Z6PZmyacEl3+1+YCSVZpj0LT5baYwS
         cNxzcVyetZs5Yfbvf+0Lyo+C7SLQl/1q/lIW3hDsvQXdX9l0GrAS9mbX4H9KiUItvIYr
         Eu04itF9qLQWQrWYGKkJOsXXaWZo4X9VP0HEpKZE9KV3rTc/fWSUYBWbjkKz//805i+F
         PZdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700730766; x=1701335566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NVN7Lm3QnNbj//OIUFLcvcVkFW66YIketLgRhLuAaTg=;
        b=UNBgeH7Y+VWmmJ6yupn1Nilv8J08LBMAMQbS8H7hjunciJwhxZjWr7UP0p+sfXKToA
         APaSzuqWRmiPRqav1akuxTz921vKgYR7/CqZep7hyLvo2jsuJ0BhYs41f7WWZZ7W5jUn
         2tUpk12LaH9aBlifxcFxW0JoECCsenlY1Fyly9+jB7ZjFONsGzM7z5zl7wIkkOBcee9y
         pmgazpDDdXAP77dxFqxImoocPBvxkgrBt7eJah36WC4MChQjmNKO3CiXk3aF+G69FA4Y
         5HPxNGkF7HHamVj2fvAkt/HNMB/F0H73+dt8phm0X40OV8ZOFMzi5QMzuT0hbVCduLeu
         0xpQ==
X-Gm-Message-State: AOJu0YyzBpSDkLwwDqT4Xh2thecZ1SkN2KqljM5yHYVTYwSdfX6e7ygk
	lLouL7R7nZUcEKrs1TL7rEt6HLpKw8U=
X-Google-Smtp-Source: AGHT+IG7qlwWMN6R5P0TIf1f+OvDFXLKL/RtGE5DQtcgkKL7oyicgIjpKwZWnPEgeN6VL04uJWKYJw==
X-Received: by 2002:a05:6a20:c887:b0:188:1281:8994 with SMTP id hb7-20020a056a20c88700b0018812818994mr6667937pzb.35.1700730766336;
        Thu, 23 Nov 2023 01:12:46 -0800 (PST)
Received: from localhost ([156.236.96.172])
        by smtp.gmail.com with ESMTPSA id b11-20020a170902b60b00b001b89466a5f4sm859697pls.105.2023.11.23.01.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 01:12:46 -0800 (PST)
Date: Thu, 23 Nov 2023 17:12:42 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH 2/2] erofs-utils: mkfs: support compact indexes for
 smaller block sizes
Message-ID: <20231123171242.000035e5.zbestahu@gmail.com>
In-Reply-To: <20231123052245.868698-2-hsiangkao@linux.alibaba.com>
References: <20231123052245.868698-1-hsiangkao@linux.alibaba.com>
	<20231123052245.868698-2-hsiangkao@linux.alibaba.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, 23 Nov 2023 13:22:45 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> This commit also adds mkfs support of compact indexes for smaller
> block sizes (less than 4096).
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>
