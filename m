Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5B6780437
	for <lists+linux-erofs@lfdr.de>; Fri, 18 Aug 2023 05:11:03 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=jkSdfraw;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RRn2F5VQzz3c3f
	for <lists+linux-erofs@lfdr.de>; Fri, 18 Aug 2023 13:11:01 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=jkSdfraw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=zbestahu@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RRn295W9Jz2yDD
	for <linux-erofs@lists.ozlabs.org>; Fri, 18 Aug 2023 13:10:55 +1000 (AEST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1bc7b25c699so3640515ad.1
        for <linux-erofs@lists.ozlabs.org>; Thu, 17 Aug 2023 20:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692328254; x=1692933054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yKpW3uMzKHMipz/jB1RiSd8Olvi+QB8PMIbMqnSLDAU=;
        b=jkSdfrawUtRZR63RxuLHuqppHYvkby9RDNZGLiEhnY4whd8qEb14oCt8G2bOBZcpB9
         VXTtxz1ifxs4zmBpNS/xSBbcywmCT/h0ZUUMjujMhfW0BjNC/umz8Cf0yn6tNarqO4li
         kJhGHNE92fqZNR9wTzfss5O55RHtA8UfxCte1NH3kVn358XA1gAjnEg2QxwSIhZ5sKQz
         wYIQSrqNaiPCLB4/zTpYFFIQKynWDgm2VOdt5i/VXWkHfJTTEOTQ88EwVpuxj4p/+fBt
         sZfdpIAMxdOvJXD1lmlDz1gO1CdFG9Z59gG0cBvZFdOpWDj0uCOxHTlibaz5WP7H4UyH
         6G+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692328254; x=1692933054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yKpW3uMzKHMipz/jB1RiSd8Olvi+QB8PMIbMqnSLDAU=;
        b=UxwOr+Fau1DDyhYeFwT588aPICn8oPqD5lY9s6r26yoK0ovec0eIWmiM9dA5R2ozqA
         BPpgQJfxuWkEEQ0Q84yNh2BFapwcKaml+5qkYYvw4B6kVNC6MiTgoC2J8NQjalNEuvbT
         ChxGwynHCgFEjQ+jXqwqwRzf7jrmkBhuDKQAU/P+tMGBF/1R/bpy2LqATwGWiOBYUaqi
         PrA5WeoOaB/BhFJEHF++aaqolLpGuLg8uVCv55OMswGhfhVhQeSICXPnavirqkhDFfsn
         Ebqkk1a4rVd8A/e3m7q7HpNZA2bX4ZjGg3R3ppGWz4QF5Ig+pIVfVYK3fRZ8evip540+
         JT5g==
X-Gm-Message-State: AOJu0YxfYPRBIk4YlZ5Ep5eK2l1smgQzWXwuRIOEM24Qd7NTKG1OLoQQ
	Zlf60IRhyhvpMl7BVlXwt7U=
X-Google-Smtp-Source: AGHT+IGP1tCxPpyohn4+Hz+ynW1rLOTgpbqwPkZ/faeicKOrsuG0G3XHZ8eITEAPFUmxJyKR/R/FhA==
X-Received: by 2002:a17:903:11d0:b0:1b8:8b72:fa28 with SMTP id q16-20020a17090311d000b001b88b72fa28mr1494023plh.58.1692328253792;
        Thu, 17 Aug 2023 20:10:53 -0700 (PDT)
Received: from localhost ([156.236.96.163])
        by smtp.gmail.com with ESMTPSA id u1-20020a170902e80100b001b51b3e84cesm494367plg.166.2023.08.17.20.10.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Aug 2023 20:10:53 -0700 (PDT)
Date: Fri, 18 Aug 2023 11:20:37 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH 5/8] erofs: drop z_erofs_page_mark_eio()
Message-ID: <20230818112037.000027ef.zbestahu@gmail.com>
In-Reply-To: <20230817082813.81180-5-hsiangkao@linux.alibaba.com>
References: <20230817082813.81180-1-hsiangkao@linux.alibaba.com>
	<20230817082813.81180-5-hsiangkao@linux.alibaba.com>
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
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, 17 Aug 2023 16:28:10 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> It can be folded into z_erofs_onlinepage_endio() to simplify the code.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>
