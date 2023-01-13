Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F821668F44
	for <lists+linux-erofs@lfdr.de>; Fri, 13 Jan 2023 08:33:43 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NtY7T17fVz3fB4
	for <lists+linux-erofs@lfdr.de>; Fri, 13 Jan 2023 18:33:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=ZaZpq1+T;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=ZaZpq1+T;
	dkim-atps=neutral
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NtY7K6lqBz3c9G
	for <linux-erofs@lists.ozlabs.org>; Fri, 13 Jan 2023 18:33:33 +1100 (AEDT)
Received: by mail-pl1-x62c.google.com with SMTP id v23so17729108plo.1
        for <linux-erofs@lists.ozlabs.org>; Thu, 12 Jan 2023 23:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nr9ttpCswQ8apK4LORys5AV0ucvWwQG6uR6ZGlqUXNE=;
        b=ZaZpq1+TqvEhnzNB+8vjM+ioiypsU6kNEm2B4sZu5m4I/FfpmhpeZKjGDIc0rf20dV
         TMxLPUfBj/rx+f0sY+bBUucR4utaR2joBUiwUYebs3nmKq9d+BzcEFusCvCL91Ct/zUY
         /ibkI3Du7ENktVdC9p89vVcvbwtDzUVtJj3sHX+SUW10/yV21f1UQSfullUBhb5Ta102
         hNTjUAkokw6K0WUUa7GWz7NlJS2scqhupilR/U/Ep8CB0LRhQEq2b42LK937+GEgnGny
         8eTWRWEWxAIRR0AehG7nUxYQ7wd5m+1ZRUC7jxm90ezKCBqhCyN4uX5+pyRajozfB6LT
         mqrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nr9ttpCswQ8apK4LORys5AV0ucvWwQG6uR6ZGlqUXNE=;
        b=UjZ79YzrIFCFwhzMR4rRZmr/pcJvpqnaqz1f9HG5i6sj3aToLQfbaQL6N0T6wpLj4f
         V0k51T+93Xr/cWtTkSbhEu2Np8pkGJv04oEKYJH6YI9UpkAv63jgSbxFLqCh4D3LzSvF
         CUhOmv9wIpZy58C2tnoY6JXCFXEvKbZlDjnOwa6m8XcWJ7aRI5BqPF2/Xiz1jPax38Y/
         juCj+jgdH+aIH/vg9yBr1qJR+so6J7wLmbxrJxALVHE9KwvDyrRy2v/q1oisIfir2cBy
         XMmuOh6775arX8YSucqcxIWY7H1jjrUnxtIjsGK5N0/4iFelyiBdj8WU9FJg0VChTah1
         9sXw==
X-Gm-Message-State: AFqh2kqdo8u0RX8YeCEVGZs0hYuqRV5G+BGowrtCOfmuM1Sspk8H3rDy
	6joqBhDysGpLJFbJOHUBY48=
X-Google-Smtp-Source: AMrXdXvoqzdRZaceDiXenPxlxL4X9EMeMiqX40DcrvohhA3eh2BRUaEnCw4OHU8SPiqJtDZKuhZhQA==
X-Received: by 2002:a17:902:9898:b0:193:1aa5:573 with SMTP id s24-20020a170902989800b001931aa50573mr9544335plp.13.1673595209200;
        Thu, 12 Jan 2023 23:33:29 -0800 (PST)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id jd9-20020a170903260900b00186727e5f5csm13367492plb.248.2023.01.12.23.33.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Jan 2023 23:33:29 -0800 (PST)
Date: Fri, 13 Jan 2023 15:38:39 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH 1/2] erofs: clean up erofs_iget()
Message-ID: <20230113153839.000057d0.zbestahu@gmail.com>
In-Reply-To: <20230113065226.68801-1-hsiangkao@linux.alibaba.com>
References: <20230113065226.68801-1-hsiangkao@linux.alibaba.com>
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
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, 13 Jan 2023 14:52:25 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> Move inode hash function into inode.c and simplify erofs_iget().
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>

