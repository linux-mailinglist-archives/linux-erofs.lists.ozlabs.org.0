Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39847949D8C
	for <lists+linux-erofs@lfdr.de>; Wed,  7 Aug 2024 04:00:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1722996000;
	bh=6swMmyIH9qc2r8gZCH/sJTxj6C70uaqV0cUv3UzhcYA=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Ym5hVAJtCBA2skxEzPaeq6Ka0Hpl8xc8b9/vOnq8IFxhKCdu/VjOHRAJa7dPaL7Rf
	 o/UK7czXv+VynBitk0uz2rz9TxbX4MD9GvmCh6GOzpG6mGTlEzrmcN2FwTYRDgiFFW
	 WBj0rBkJUyYFLyRZjoHCRNclIjlt8LYf/o8xSeotTU3cSXQaQLSyKhY4Aff6wvIIzy
	 fqytPZUdaTIZek92RvdbB/JAPJY10DXFQ653bgM5JqfKT2csN5stIkZp+XLHoalp5U
	 pOJBtdmmFBkSwQXt6P5zisC9jlaWsNrXrcO8uZcMav6JLCt5ACh4UyX1ZXXW8uNw4f
	 zanN5tQCLlScw==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WdtfS3jnwz3cSN
	for <lists+linux-erofs@lfdr.de>; Wed,  7 Aug 2024 12:00:00 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=qij5rYOh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com; envelope-from=dhavale@google.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WdtfN5lZSz30V1
	for <linux-erofs@lists.ozlabs.org>; Wed,  7 Aug 2024 11:59:55 +1000 (AEST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-4281d812d3eso12197245e9.3
        for <linux-erofs@lists.ozlabs.org>; Tue, 06 Aug 2024 18:59:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722995988; x=1723600788;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6swMmyIH9qc2r8gZCH/sJTxj6C70uaqV0cUv3UzhcYA=;
        b=ow3LTkF3/7/kDM5KGvYozBIJQlv9UFDWVlCe27FLBO4B3fLjl/I8PgESnGTllD9UCK
         3hmoPb6QQPHPqpZxUV+nzIsFmY71/tzep1FeDuAVN+qSP/+YMDz+nVXrzzoeMYMUOfOV
         mbNnmimq8IVhXaqnxG/Uraqno/MbqAnSDGmE3aPXjJ7rIxgY5aP1670xECh49ajJz90W
         9fqj41VgiYDxMiJe4LOpCFAoqs39lSTGYQuo4AJODATtthrk8UkqOf4HtHwN8MODgMue
         1V6vb668dC10QZ0/fP/z425XbV2fmtIm99uA4EmuT1IMnpKec5P2UfmNzd3rJuA5JyRy
         h+DQ==
X-Gm-Message-State: AOJu0YzLjT3DQEsMacV8LD6JlfbSjnm93QgIEKyAGXZrPjlfrEnTkrn0
	M59HetEyOgZ4R18Zl2D7UAFyCQ3ES1r8v2El/PKHmGlbZ/yxJ+DgjWPR2VLyMS9+S993svKYJH+
	XYA/m5ihSSqmqslRUle1FaGds6+/0NOrM9Z1Z7kesZvwlrhMc6yXL
X-Google-Smtp-Source: AGHT+IGKLTWJkUMhBpZHLWO708ZbAn7qTA+8RhzekMl/VbDr7FpOeJKgKpA3+NZdYcL9nux3YN6X1cNvy7PVczsBKwo=
X-Received: by 2002:a05:6000:1e83:b0:368:319c:9a70 with SMTP id
 ffacd0b85a97d-36bbc0e0c7dmr12051161f8f.5.1722995987612; Tue, 06 Aug 2024
 18:59:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240806112208.150323-1-hongzhen@linux.alibaba.com>
In-Reply-To: <20240806112208.150323-1-hongzhen@linux.alibaba.com>
Date: Tue, 6 Aug 2024 18:59:36 -0700
Message-ID: <CAB=BE-SpBK3oL6P1LDpknUWrwuh79R10XzZY7ZQB9p8Zncfstg@mail.gmail.com>
Subject: Re: [PATCH] erofs: get rid of check_layout_compatibility()
To: Hongzhen Luo <hongzhen@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
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
From: Sandeep Dhavale via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Sandeep Dhavale <dhavale@google.com>
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

LGTM,

Reviewed-by: Sandeep Dhavale <dhavale@google.com>

Thanks,
Sandeep.
