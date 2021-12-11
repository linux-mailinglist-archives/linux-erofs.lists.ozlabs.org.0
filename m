Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C10F64710F0
	for <lists+linux-erofs@lfdr.de>; Sat, 11 Dec 2021 03:23:18 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4J9s503dJ8z3cNH
	for <lists+linux-erofs@lfdr.de>; Sat, 11 Dec 2021 13:23:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=NegDbuSw;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52e;
 helo=mail-pg1-x52e.google.com; envelope-from=zbestahu@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=NegDbuSw; dkim-atps=neutral
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4J9s4x4yPXz3c9h
 for <linux-erofs@lists.ozlabs.org>; Sat, 11 Dec 2021 13:23:11 +1100 (AEDT)
Received: by mail-pg1-x52e.google.com with SMTP id d11so894333pgl.1
 for <linux-erofs@lists.ozlabs.org>; Fri, 10 Dec 2021 18:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NXMcZASbS5A5LuGaITAUWZnbGzULGtXkyd5ls2BezUw=;
 b=NegDbuSw673lHhuR1o4zqbxmirvRu0kWWw988Cebd71oXikIOTGfKjRsE2EuPs5H6E
 QJLBJiOZANsYF4qBEmQrJGLRogsU/Kh2CtDBW4BXNtU7KkkM2MbxE/kLVTouNrGo1MxH
 R2YYKuMu9Fm7PXtuaX8Kh9MjYpyHEHeugBaWt+F9RYUh3nv52v/a7jIICPBgu19S9R7X
 eW49RESzsz+5uphUB7WROuS3Ut8rLFiAYmbitbVz7zDxHw3IJ1z8rJO0yM73stNHzvnl
 yRI6RTGe7NTnSBvJtARaLf93JY6c3hsYit7NRiimkp6h0dUqBRnsyQoMfT5JpclUfy9Q
 KEGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NXMcZASbS5A5LuGaITAUWZnbGzULGtXkyd5ls2BezUw=;
 b=WsTOBoVXN+1qEx0EQpducmf1bj6jNJ7UZOXm5BlEI8pZ5rcBVgVrwu8YLPKU4Lx3rq
 Jr1HqtfO6Ldmg17eeGqS8y1JlH1j3jBHe5OL3Xkao/1N1VWQTcozxzft7rzcANnJr6TS
 BgKL+riTRTuj+HRoBMZ8lA9w8KOAHD7QUaVUHX8Bb1jaK8jsLNvEODoCMFmf+wfse/rW
 pcxZuDqRG8acON6sN/0ICxt6OgppAPeLLVJ7U27942uBuEgFx32Zu4HTijtXlncM5iA7
 4Yi+MLdK2sCU0/FUdFHJ4AwE7Iov0Zttjiwf/DGDblcf0s+OjuBTZNwL2jUAaDe71ZTt
 pW0g==
X-Gm-Message-State: AOAM530zfOvEMI+yeQ/x+jdDU0iVS8pHlO1owgAy7znfTSSEu+jH9UFz
 dkRmTfL3zATHETZoxQ9CULg=
X-Google-Smtp-Source: ABdhPJyozWNgUjFjOeVluyoQIzv26md3UjjU4DQHpC0/u3vV6uje1BvIUIb3GcLwrVkCboEtftn2ng==
X-Received: by 2002:a05:6a00:a89:b0:4a4:e9f5:d88a with SMTP id
 b9-20020a056a000a8900b004a4e9f5d88amr21445509pfl.28.1639189389517; 
 Fri, 10 Dec 2021 18:23:09 -0800 (PST)
Received: from localhost ([103.220.76.197])
 by smtp.gmail.com with ESMTPSA id ls14sm277617pjb.49.2021.12.10.18.23.08
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 10 Dec 2021 18:23:09 -0800 (PST)
Date: Sat, 11 Dec 2021 10:21:10 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Igor Eisberg <igoreisberg@gmail.com>
Subject: Re: erofs-utils: fsck support for --extract=X to extract to path X
Message-ID: <20211211102110.00000a8f.zbestahu@gmail.com>
In-Reply-To: <CABjEcnHHFe-1YbWjcpMXXuM8Dd1a+tgWTbATP5hOhQ_+PDBZMw@mail.gmail.com>
References: <CABjEcnHHFe-1YbWjcpMXXuM8Dd1a+tgWTbATP5hOhQ_+PDBZMw@mail.gmail.com>
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
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Igor,

On Fri, 10 Dec 2021 17:53:13 +0200
Igor Eisberg <igoreisberg@gmail.com> wrote:

The patch should be submitted by e-mail "inline". The easiest way to do this
is usine "git send-email" which is strongly recommended.

Thanks.
