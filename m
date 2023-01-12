Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E75666AFF
	for <lists+linux-erofs@lfdr.de>; Thu, 12 Jan 2023 06:51:39 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Nstw94GJnz3cD5
	for <lists+linux-erofs@lfdr.de>; Thu, 12 Jan 2023 16:51:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=MhST07T8;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=MhST07T8;
	dkim-atps=neutral
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Nstw16WG4z3c4x
	for <linux-erofs@lists.ozlabs.org>; Thu, 12 Jan 2023 16:51:27 +1100 (AEDT)
Received: by mail-pl1-x632.google.com with SMTP id c6so19184601pls.4
        for <linux-erofs@lists.ozlabs.org>; Wed, 11 Jan 2023 21:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5rBQAhwJ/h7Ix47aDcoVFvyrWd50STgT8QcojZ3vAac=;
        b=MhST07T8Tuj+OJjQXZqhrbjGcoPY/Mic9gSizmzlaVosDRuoGreCJ4zph/x9CxLwdc
         pzxZacy9/siux4CZE7LoqErOtKKh0ZXPbngWgONXyC1mZCCpJkd/BIgLj3pubHwwCH4Y
         btarwcgAzL+cbRGc4A2uPpRvN5V80CTLKn2ShJZ56BND/oAnz/I19BYJBUSCICrn0qUa
         xWYHPpDWsqDDjiY0MZmv20iV/3d19LNruNVgL4EqBlbXw49jE7iPVRuxB3W1DzARBVpJ
         v4okFvWiwbcCPjMc0+kmnLHuWNQUXV/O9T9UJM+WiORjjwBQT+ty53IDDXiLIcms2YpK
         RK5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5rBQAhwJ/h7Ix47aDcoVFvyrWd50STgT8QcojZ3vAac=;
        b=smqOdEZqU9yb8axnFmxVU9xPSAfsFsfDZe4ikKm/LPHccskQn5FC6l6vVAtqw7xUuh
         kaMnG3Gb61d1Gw1MoF+2kAK82+Mm4L+9/frJJ5hWTnXW9K95+4T2yJxELU+c0L3/sozR
         jPzxYqmLvhQuQWS3H2DR+TuakUKHsfJKopSyP3DVgWM6ZsWVj2BzKI9N9t0exVJSiWts
         XRLWHb647ReFQ2HTE7KHeuKQk/BnxSJ4loZYFRxpDfQxzdUDDXeYHrkuITpnmk9AXaoZ
         z6Khq25GRRbvmBETMTFPO7ZYaiUPQVg9HTo7LU4lnmtcGbwzIZDrJiBFtuq6vNCJugjG
         Xjzg==
X-Gm-Message-State: AFqh2kpebAk620LN/iie9LX3vvhROxJqVyVHHSFsdoQUvzvKtIp/8Hbk
	RXGnN5eQGHLAQ3RDlJMTdn0=
X-Google-Smtp-Source: AMrXdXvojwrF2D3prsIUzq+FRo9IlF2b3RQ5mHJkgM+dFBMn8/meTh8XFE+N7MuIf8gj69jeOjDpmw==
X-Received: by 2002:a05:6a21:9017:b0:ac:72ab:4490 with SMTP id tq23-20020a056a21901700b000ac72ab4490mr76529039pzb.27.1673502684360;
        Wed, 11 Jan 2023 21:51:24 -0800 (PST)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id h18-20020a656392000000b0046b1dabf9a8sm9325592pgv.70.2023.01.11.21.51.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jan 2023 21:51:24 -0800 (PST)
Date: Thu, 12 Jan 2023 13:56:34 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH 2/2] erofs: clean up parsing of fscache related options
Message-ID: <20230112135634.00002ea2.zbestahu@gmail.com>
In-Reply-To: <20230111081547.126322-3-jefflexu@linux.alibaba.com>
References: <20230111081547.126322-1-jefflexu@linux.alibaba.com>
	<20230111081547.126322-3-jefflexu@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, 11 Jan 2023 16:15:47 +0800
Jingbo Xu <jefflexu@linux.alibaba.com> wrote:

> ... to avoid the mess of conditional preprocessing as we are continually
> adding fscache related mount options.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>
