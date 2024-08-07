Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 671AF949D80
	for <lists+linux-erofs@lfdr.de>; Wed,  7 Aug 2024 03:52:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1722995536;
	bh=mxF5CpK37PzSg2uqZvPpQPCG1k+7DLCItTII5G6NW1k=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=EP4jcFkskg878WOeXXYCwfdYMA2+QCPapD9/kxqu+Ixkaxbkmwiu0zi02atIIgYd8
	 D1B+TNjZU2qKWdSQnA8wEcaIlP1JSE/fiseKlmE5GEpCoMrl3LMIuqTwQMk5rcy2E1
	 9cOEhcD9+VK43qoYXPp5t5rIYD97ps7dgTXFiCuN1hWmKwVE3scTwAUv0wnkwoI/yi
	 TGhu57ABf0HbOuRq1QwVB6RO/a6H955uiVic7G280B8j2pueR5nfcGh3aJLcOQlJJv
	 CkfmRXLzqEYKPYWskDCCG33FnF7QCmTQLslBIm+XSYahPi2txOm0RG46+7j+VN6U4b
	 /T1w/RXIO0DGg==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WdtTX2Hl8z3cSN
	for <lists+linux-erofs@lfdr.de>; Wed,  7 Aug 2024 11:52:16 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=x2MOEIgL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::429; helo=mail-wr1-x429.google.com; envelope-from=dhavale@google.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WdtTR68LFz2y8q
	for <linux-erofs@lists.ozlabs.org>; Wed,  7 Aug 2024 11:52:11 +1000 (AEST)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3684407b2deso647631f8f.1
        for <linux-erofs@lists.ozlabs.org>; Tue, 06 Aug 2024 18:52:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722995528; x=1723600328;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mxF5CpK37PzSg2uqZvPpQPCG1k+7DLCItTII5G6NW1k=;
        b=E9MYfa7UD2x5LeQIbpVaGzquS+ug3PovvIdyc/i7h8K/lD74lgkngCxtEYddg8jHUy
         fgP6TbKhB+4eKTV+kzL27vqU4+m0SH2WXDcNpYeSl/itZsyVeQaaKga9gUYdG6u0yoqF
         V30WQXoyGZgsDUpPDZIdRY1gjz2JxSjmhbz3rly+VdZuEb1AFGJOsmdmVlPaEC2+pixJ
         pLPCx5P3aaAAgiz7RCYsg9rgvXoog6nTKmHXhWjgDWoMQUDmNrzGMaJEaWWamxKtA9lp
         sXCXKJ3yjYD0RpubochYfEOxslznIQve7zJbXYEWjlqzzTShWkCmfLA5JDArx9b8hCIJ
         Gs1w==
X-Gm-Message-State: AOJu0YyMWU9v8uhIkWdyENRlYKv55mWZk9KBU6vDPLXVDJ9nBZQL8T7B
	ixR07IAcAeJ2EVuBitDdlOO7cfJuuGtqYGRFaCp1lU3NDPOT879xBviRh2N0MJMQKYZjwLZuG7l
	GCO+Wsa6jdG2NyzFLsUMh7kFbeRFT7JQbXyI/XqhavnNYMlVEBT74
X-Google-Smtp-Source: AGHT+IFidTfc1b6S8UmjPufEYKqFlUd2Bqjpy2umv/CSLKXpxWmDOXK7IzZpo+qU1fZ6jzpncgGMwlK4ZZnu4BY0Vcw=
X-Received: by 2002:a5d:624a:0:b0:368:48b2:95ec with SMTP id
 ffacd0b85a97d-36bbc0bacf1mr11534198f8f.1.1722995527374; Tue, 06 Aug 2024
 18:52:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240805032510.2637488-1-hongzhen@linux.alibaba.com>
 <CAB=BE-Q=wWXuai+pMgQMEBe0oODRNM7MVkzu5bZ2K60JmXZv2w@mail.gmail.com> <f829e10f-ffd2-4907-899d-cd2ca40718a8@linux.alibaba.com>
In-Reply-To: <f829e10f-ffd2-4907-899d-cd2ca40718a8@linux.alibaba.com>
Date: Tue, 6 Aug 2024 18:51:56 -0700
Message-ID: <CAB=BE-RZR67M+nJY2YaST3P2PwJogZjm+0PZ09Mc1cgPG-BFOA@mail.gmail.com>
Subject: Re: [PATCH] erofs-utils: lib: fix potential overflow issue
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Thanks Hongzhen for explaining it.

Reviewed-by: Sandeep Dhavale <dhavale@google.com>
