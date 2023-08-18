Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6407803B9
	for <lists+linux-erofs@lfdr.de>; Fri, 18 Aug 2023 04:15:51 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=klNiBE44;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RRlpY0t5Hz3c3f
	for <lists+linux-erofs@lfdr.de>; Fri, 18 Aug 2023 12:15:49 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=klNiBE44;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::22d; helo=mail-oi1-x22d.google.com; envelope-from=zbestahu@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RRlpT5SBKz2xG9
	for <linux-erofs@lists.ozlabs.org>; Fri, 18 Aug 2023 12:15:43 +1000 (AEST)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3a8036d805eso308778b6e.3
        for <linux-erofs@lists.ozlabs.org>; Thu, 17 Aug 2023 19:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692324940; x=1692929740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+SaTHwiEjgsVhtsIihB7iyaYd7Jgod6PGPpwHIIV/U8=;
        b=klNiBE44VqNDhtXHWlh1kMNlbwPRgEsgWVhIaahN+PcLODg/+6KpIaKz4C4HENpf34
         YgOB0898laja6oXSqm0Axx7fzRUKn4WN9ZNhlPWZknzXLeC1yyG9x6GyqV/RI7hE9DUG
         jjoA/dvcgMlwnb49lR2jStH0qmKbxY6rH7131kLG932xsupiw2HqOf1z3R3Pw2hz7LLd
         yhe1QiZczXmyJEl01UTZoORRUOFpwUZnSZcakfXM1zW89DmVoYMT4YexpEswzvgO8/ab
         R9OBKObQOIClCh+p/qyZUatCdiHAAvNqvxAmwXRks2Yz+/IVPvQxpO9CJA0XYb5VnGrx
         VUng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692324940; x=1692929740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+SaTHwiEjgsVhtsIihB7iyaYd7Jgod6PGPpwHIIV/U8=;
        b=JlFXJYGvXeENlFiXvllG8h7+WyxTY7YalhboVyD7y7KGS/IZ8p7v2K8/ib4NCGP193
         k5LCD0OncMUwFU13jqNmsCcL5N9mu0pI9XnXEdEMFY4AiMFle4qWNxWbQQzClGCKuxcI
         yDlV7K7gEEE/5NF/fLxANXtHa7E/xmHcQidc9ak8HkOB7Z1wK6K4rgUbAQzrArqLs+1j
         rgddyV/XJcoTrue/N+6dlbhoEysxfYx4WD1GpmY+D3hfabfyyI3osTEYobipaIhYr5jA
         YigyPybO8LKboVMhtbZLCXmzWMjG2T8rnArEeMBeNBQZeyBB++hJAQJu+3dvHJ4SDwm7
         CdUw==
X-Gm-Message-State: AOJu0Yzqtt28YONv1IonAmBfRaodiHZEOCwX+DrX03/pwr/ZDjbC/BT+
	BpurXHZZnNsSPTFv1/PijQo=
X-Google-Smtp-Source: AGHT+IF6r5pEoBtxoShvOijBK04Aam8XvhJfd7tw/By5BxZxuXB6Z3WzByrf6TqMRWjz4V3bXZGydw==
X-Received: by 2002:aca:2414:0:b0:3a7:4f89:5b6d with SMTP id n20-20020aca2414000000b003a74f895b6dmr1145845oic.58.1692324940397;
        Thu, 17 Aug 2023 19:15:40 -0700 (PDT)
Received: from localhost ([156.236.96.163])
        by smtp.gmail.com with ESMTPSA id k17-20020aa78211000000b0066684d8115bsm419604pfi.178.2023.08.17.19.15.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Aug 2023 19:15:40 -0700 (PDT)
Date: Fri, 18 Aug 2023 10:25:23 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH 2/8] erofs: avoid obsolete {collector,collection} terms
Message-ID: <20230818102523.00007553.zbestahu@gmail.com>
In-Reply-To: <20230817082813.81180-2-hsiangkao@linux.alibaba.com>
References: <20230817082813.81180-1-hsiangkao@linux.alibaba.com>
	<20230817082813.81180-2-hsiangkao@linux.alibaba.com>
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
Cc: huyue2@coolpad.com, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, 17 Aug 2023 16:28:07 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> {collector,collection} were once reserved in order to indicate different
> runtime logical extent instance of multi-reference pclusters.
> 
> However, de-duplicated decompression has been landed in a more flexable
> way, thus `struct z_erofs_collection` was formally removed in commit
> 87ca34a7065d ("erofs: get rid of `struct z_erofs_collection'").
> 
> Let's handle the remaining leftovers, for example:
>     `z_erofs_collector_begin` => `z_erofs_pcluster_begin`
>     `z_erofs_collector_end` => `z_erofs_pcluster_end`
> 
> as well as some comments.  No logic changes.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>
