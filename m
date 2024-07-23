Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9619398FD
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Jul 2024 06:51:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1721710296;
	bh=ldg+LbqnHJ9gwDMdSZ9tPLEGrNZoIczhjCXH+CAGglY=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=jgxoCqBzpYP5xa3ejdyqGoMeA2d8DnxmK2aEYjw/u6SzPPkQkohGYZ/8ZdZ5vA74a
	 k4ADtop2s05BhqTcADoyO4F6XfmoUzKLEWuu2A3LKQ8GJKXNIx1j/gdCafM+tSw2oo
	 Vf8MvS9FTGJdYFwMrupjHH4d2zSO//rIcPyRs7YqEpm0CBNDiP1WUxrJYWi9vd7Ahe
	 EfZc5a6RAozLyTXz37hXoDxriCuNsyJYhWx5OAfa+PnNmOTAPq6VHeXjcqtU9zTK3p
	 4btrmx5Sgb64ubTJnPrEgW9/t71eOnEa13meRqA1MQ9CH1m8rIOlkChnqdrChIJ5JH
	 bw+tL5vMgDSRg==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WSl9N1dzMz3cVH
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Jul 2024 14:51:36 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=NbhLNdu8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::435; helo=mail-wr1-x435.google.com; envelope-from=dhavale@google.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WSl9G6qszz2y8W
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 Jul 2024 14:51:30 +1000 (AEST)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-368380828d6so2553980f8f.1
        for <linux-erofs@lists.ozlabs.org>; Mon, 22 Jul 2024 21:51:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721710284; x=1722315084;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ldg+LbqnHJ9gwDMdSZ9tPLEGrNZoIczhjCXH+CAGglY=;
        b=OhtY/CALH/x37olHYg/HGa2F2qwZ7A87gSH5T1za1YBffiDU6XtDKAkRPuXy9ZLkyT
         ++hwCtPVAXf/GR5cd8WQ0Z8UmwQUcxmoVO1BrQNDJDGXzZF+3ZJpyTNL01gx30cLogaZ
         g7J5grlr7Ba5ncRgZEDhAe/xVFF0Qr8qyBc96tpaA8vlg7xF6/JqcwhY6WDREOSPTyUS
         RP64/r/WAn86ehRp8cdmhCLC/f8qoL6qntXt/hlQqv3hCm9zbzHQXkCJCNWNImzell88
         xhjt/0pLET+MkVIk7IWG4J4iTlF4xaGwMV88wwLwGbE/oXKKl3OjxSLl6HybRwLyUnPG
         WoLg==
X-Gm-Message-State: AOJu0YzHoAHwkjHhRu592tuYSAtEPLwPi4RLiBL4U0qpqkPLN/5AfO+0
	THR2wHSvrQK5WXsuIIlrGfU3F3/3J/6SLklg1kNfhnEZ8bJ2uKG3y2IzWSse2R2C5augRp9Kr1F
	p1FPVDXBNwjDRJusHsuHASYyrmeJ6ESbFDFMx
X-Google-Smtp-Source: AGHT+IG2djanOPTkwqVUsbPFqeMu/LXMrh5LaVa2ONuno1phEQZhKl74d/UNoiFTlwT/EaSCIcRczcStMaWrTCnhUEc=
X-Received: by 2002:a5d:4576:0:b0:362:2111:4816 with SMTP id
 ffacd0b85a97d-369dee56da3mr1046156f8f.55.1721710284258; Mon, 22 Jul 2024
 21:51:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240722035110.3456740-1-hsiangkao@linux.alibaba.com>
In-Reply-To: <20240722035110.3456740-1-hsiangkao@linux.alibaba.com>
Date: Mon, 22 Jul 2024 21:51:13 -0700
Message-ID: <CAB=BE-Qqrtew6KKEjLfiEtcc0SDtP8PMhtby27OtF2eD-dD_iA@mail.gmail.com>
Subject: Re: [PATCH] erofs: fix race in z_erofs_get_gbuf()
To: Gao Xiang <hsiangkao@linux.alibaba.com>
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
Cc: Chunhai Guo <guochunhai@vivo.com>, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

LGTM.

Reviewed-by: Sandeep Dhavale <dhavale@google.com>

Thanks,
Sandeep.
