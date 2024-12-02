Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 647CB9E0E05
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Dec 2024 22:41:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1733175670;
	bh=y98Kf8HpzpzyCovegzG/2Qrqlm+uOAvAxYSvXUzhhdE=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=akrFfXPz5y44FyR7QKplc7fNhHs6LRyp3ItZ110cctHsIEawectc9y70zrVkFB497
	 EBdRSLuUB/iBiRHXlGhznefuC50Jst6sLTgJLoQaUUC+sYPI28GsSnVy/J2JyAHa7J
	 ghON+P9UvC5xMDWQDaCIK8FFl8KSmmrA6P7Tw82d9VZdWyRu/0+CjertiI2kIoePPl
	 CXMNvfrlq4DMK2gVWijYys0SM40eYS728LEX2G9QwFLJ4rY4JIlqL6Qd4+vtd04y+H
	 Zr2Ksdu23yYnki5u5Xerr5p+ZWeMiF7mgQkRlnvR/c9d0dwJekqHbjeRDlvKBWJAWr
	 tACTq88blecKw==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y2HKL2SYJz2ytT
	for <lists+linux-erofs@lfdr.de>; Tue,  3 Dec 2024 08:41:10 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::431"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1733175668;
	cv=none; b=RWSBz5ZdZ6zRqeUXUrLw/1ExH0xqO5TrpT3i14iBF8axfp5ZmWIHL2Skk7SV/kjkHIQqMqwwDUZCNJt1fAcDZTZL6c5aTFyRKNSKkChrkqTg86syXw7iN1BIR2JAi7aYeukOGf2Bgfe/5CU9XfkgAjTPCeEgmsGaAuMs+Fm50hfzKejJY6R/KCcS/WTflNtO1pMarUB40QiseLcrH1T/7CW4C7DWvnw5nkuNp2ROcHsDAGRtjHpyvnmFPUb6LG4khOZoOlKIxBfW9yIQu2reJ0YRKDVCoqKeW7x16lRCMtxxw7cboAbaM8kx9vOo+ckEBX4p0xMh6iDdc7aNI2xGig==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1733175668; c=relaxed/relaxed;
	bh=y98Kf8HpzpzyCovegzG/2Qrqlm+uOAvAxYSvXUzhhdE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BxdeVZsLmoxScWFqzhUQiBhYAk2Qtvg96dEeWtCl1ZK0ivHSdfTZkkW3R7hXDnA6SnQMCsuv/YPzedt2JN2iWUGjzGfFusOtZJZEKCnrD0aKiGRumCkp2ikvuVCq0oH+6HiQ+4fDeNq8GuToH5y3h9r1I+9nb5kyfo1DyXh/pUMaaudbCH/5rMpZxxGp3AY8t2uT7SFCaiGhN8wA167QbWVGHlpY+HR6vVlm766wpwVqq80B/jieV/bXHcb47iRfI28ccLHLiwjuwZPyHb1/+L9k4VIwkgQ0KxXVo/C3zUeLF8e3XTLiyYrH5xissQ5jTB72Xoepi4J1T3j9o7KM5w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=JcRTW/D3; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::431; helo=mail-pf1-x431.google.com; envelope-from=dhavale@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=JcRTW/D3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::431; helo=mail-pf1-x431.google.com; envelope-from=dhavale@google.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y2HKF62L9z2y8X
	for <linux-erofs@lists.ozlabs.org>; Tue,  3 Dec 2024 08:41:05 +1100 (AEDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-7256dc42176so1640506b3a.3
        for <linux-erofs@lists.ozlabs.org>; Mon, 02 Dec 2024 13:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733175662; x=1733780462; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y98Kf8HpzpzyCovegzG/2Qrqlm+uOAvAxYSvXUzhhdE=;
        b=JcRTW/D3iw1NdEiTlxM5/9k+LxuoUw/+PrEpcwfi8X8gTpBlJdA2KOW4uU93Nc9oJS
         euSLCBit/XyTfx7AuBAndgihN6lFrDwxQ875wIPm+3tVvavkyg3fQ5EzPwZoqg39omMV
         fR9/zCd6ZCZqWzIWLAQZ+hVGqcQsA2C3VdAA6TxGwQ+Oss8t9/REhl81JzFheY1+rEUh
         qgjG+NvUO0bDT4zwe2HWsv+fMR8zMW1GWSp5EuNBVrFSapxUw7BeO+J+x8YafyDTy6pt
         uqESvpl5iDZd8E5cjEOBpnbhLd3zEAbak93eAziIFoW7LJBRgaH4m+xqz7O8pLgfDSTo
         JGcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733175662; x=1733780462;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y98Kf8HpzpzyCovegzG/2Qrqlm+uOAvAxYSvXUzhhdE=;
        b=UAtUNhlyWCwvruvNbz31XeFHMBu9T+C4hpSKdhJ6y28PefvEozJpOmu3R+amHsqVC3
         yc6jJoTdEnR9Qapt/gVmL89QNoWLxkQ5LUS8RRpJAH6tpZwpS96bikPDxxq7MMoBX/lv
         PIlZs++dP25NMuttpkUcY7w+KaORRc38f4TuvlXSpWXIJ5Vf9++Tq5HDVcdX5Dabn41D
         Knk4UFOq07WdnJ3zCdiZVVcLfMYp1rTX4hl96OlFxk1Ps0H0wniNNNTPRlXqfx/yx4rC
         NiT700b3Z5iPb2zapBkLPvWCfNyJrTPouvRT2cfr5Q6yCe5eVkLMRQUmQegeHcfnJojx
         6bFA==
X-Gm-Message-State: AOJu0YzksPXqMbz9gujjKzZme8FKhGimpHXtg8uRxCXY+7RIsz8uiaqk
	PoYqPxoO8a18SFkmqPJBYzCLvLPLzhdlIePBKvIZrv25wOhgGz8ghs85wvR1ZtOMDm1EEMy0sqN
	xM+3zyGJ3boYgtNb1SmM+ZGukIwAcv/dGHUvA4RuNplTgnf0tZTRV
X-Gm-Gg: ASbGncuvyMLHFxIQ1xJT/HxOsTZX4p6FxphOoxjj+uYpM3MyEs9GAbXaon0CiM1TLVt
	J7JheeTdQx2hRgCqkK4TI8HorAmGuj8qL3XvXj+6Cry3N/QOHHsGaS0+U40N3+Q==
X-Google-Smtp-Source: AGHT+IE3KCnsQogf1K2mfjUMzmcsIs1PAs6XiEvPvHrI78MmR66yu2M4/Lg58qjih39Qlb3W8xE6wD7xowaSOU+WNx8=
X-Received: by 2002:a17:90b:3a92:b0:2ee:9d49:3aef with SMTP id
 98e67ed59e1d1-2ef01241e85mr122528a91.23.1733175662245; Mon, 02 Dec 2024
 13:41:02 -0800 (PST)
MIME-Version: 1.0
References: <20241202024019.85901-1-hongzhen@linux.alibaba.com>
In-Reply-To: <20241202024019.85901-1-hongzhen@linux.alibaba.com>
Date: Mon, 2 Dec 2024 13:40:51 -0800
Message-ID: <CAB=BE-T9jAjf86S9sBCmPk8ghvte+RfsW6smS0Z5=DU8ve4wcA@mail.gmail.com>
Subject: Re: [PATCH] erofs-utils: lib: fix user-after-free in xattr.c
To: Hongzhen Luo <hongzhen@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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

Looks good to me.

Reviewed-by: Sandeep Dhavale <dhavale@google.com>
