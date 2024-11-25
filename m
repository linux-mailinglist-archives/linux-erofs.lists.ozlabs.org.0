Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6626F9D7BD6
	for <lists+linux-erofs@lfdr.de>; Mon, 25 Nov 2024 08:04:47 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XxcCG2MK9z2yn4
	for <lists+linux-erofs@lfdr.de>; Mon, 25 Nov 2024 18:04:42 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1732518280;
	cv=none; b=DUosGhL7P0nxr9pXoQHA31gHinYmJfEDupxAKwtHHNcM1KAQIWNKujOCgTySyPE5aAy/2/stgszX41i6d26wMKUQntfCs4I5zFvbBugKqhDf01/tOLCX0SvSqBAOTLA7/EQUPcxmHaQrqFkhjBzq4SMLbmyQbsucqMHZMxdqkzxTw4znAkjq3MQaEvOhJ/+fJrhgJMqJEEkle0ITmeHoKXxdDoqmsYQdYnGyCCMfCoQHwfE1+kOpg0+eGEADhrUFxxRwCcSz25yIuv1pxieK3P4agoO6SXS9pasKc0zca+OxvrCD5I5haED1S2xHD64YoIWonGoKE+JXn3p5ZtbgaA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1732518280; c=relaxed/relaxed;
	bh=5vcp0J7zk08bcGnG6ixoY9FJh5UMVRDDbvoFP3uqAdc=;
	h=From:Message-ID:To:Subject:Date:MIME-Version:Content-Type; b=FUiL5Ezu3rnk/unD9ywGqudeZUNU2j/Y+dFtx8dzPv9W/5FMb6eYEdOVq8R923Juo/ksnpYXhZ6hk16G/VKI8C0WpbnqslKxjBe+UqxLafeW1w+BcCTLaouzgpWsD3cKwp9rLU7SJjuygv9BXwz5+KDBrSuCZndSFthaErcTILJDo9Jl52XAO64PU2SQws7ULeVF0hQFuksSbmkePDoh6sZxEQgiGDCwnfbbaip5TkVLgBmQRDN9VNxHTVIYqY86vlJDZSJKiUjJ/Ueut7LsOcjuukmVtIJawqS5USmdyomviNhYqnAaHN0wuNslvXEqbWy/zvQNxoHDSAZk+X2ilw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=RsXz8EN0; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=bmhyasin@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=RsXz8EN0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=bmhyasin@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XxcCC4MhSz2yK9
	for <linux-erofs@lists.ozlabs.org>; Mon, 25 Nov 2024 18:04:38 +1100 (AEDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-211fb27cc6bso40026825ad.0
        for <linux-erofs@lists.ozlabs.org>; Sun, 24 Nov 2024 23:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732518273; x=1733123073; darn=lists.ozlabs.org;
        h=mime-version:date:subject:to:reply-to:message-id:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5vcp0J7zk08bcGnG6ixoY9FJh5UMVRDDbvoFP3uqAdc=;
        b=RsXz8EN0mZPXKOLapV+s44RwEvW5qUVWWn9Ru8JHetfOvQmHEDIFWNtvmcShBDxerm
         IE10hbV69jwXcQA+9mlFXwak2YK9Vj4lwM9BfvUI+XgCewFau5O7CnK/axs2KeG+tAOu
         HgXffCJnIy1txDKQN/v5Hs5EEjJd3UWqJT6GdbYSVIZMSJKkgaf6GI4gSpWy2Ni+c0ql
         3k9EJhm6rx+UyCvMKu97fMOMRm/NqIDAhghv/Qu+pseZgVkxW1f5Yq04j4FlSZwqcFl5
         syuHIX8RCbpoGe8CtoAfiybY/h3B5p7bu7Lq4VElRssRGYZdnayOicZkQJrC/X95qId8
         mYjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732518273; x=1733123073;
        h=mime-version:date:subject:to:reply-to:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5vcp0J7zk08bcGnG6ixoY9FJh5UMVRDDbvoFP3uqAdc=;
        b=km2sU1xGq2k85XagHCzRgx1Kp/VQJD+B9mrCKuNARHdzTn7oG+4EqIMlTUNzZq7LLR
         0Vf3NoCedL3IjOfC6eG6jDKIrbInVSfxM1mlIXmuDWrTgJm3uhwi6Lu19m6L7bYi4aoq
         75OXk30pGm21oZVTnF1V560uzEjkDRQyIb/piCdb7jnGxYF2IuzOvRZSdA4Prd9ljXxh
         /oiUEF3OftVRoEJoTuGj0sQ9hxHfI72Cy4Mrbfrs442Rgfy3jeUb+TBBdmXJq735r5qA
         ASCkPqPHwKZX+Bb/1vwl1y3KJzPq0WEDaK/TtmJM9GtoXLnfBo4mo1tJVGgcPrrcQl7/
         +K2Q==
X-Gm-Message-State: AOJu0YyUgfG3q6j1bU2l69uCXy5l81wATLsYz6ozRwTUFJUBAGnJVTkJ
	bFYvZR5hjUaMiKXkFSTFdJwlfpkM0L3y7XqbrQ0ctEDutzqw7bX+3uYkRQ==
X-Gm-Gg: ASbGnctusnaRPOJswm17Z35s5MPpeVHT4nLdLebNdPI+KfqSEHys/k2BdbX1bl4/pGj
	gkZ+KlYra6WJt/EfYEYCfVRM1MLT/BkvxjhNt6gPqvzdXH2s83t+AUvKd75U8Qx+BClro4XsySb
	44fxf1hi2tJq1bFs+rBJVekHYWOlX61TAsE+LGhpfSoPQbzoYtcdkMFTsAQOSGH9aqHB4m3TGCG
	V09lLeIUFE3sDjeO6r/e+fXwvOW1OgG/d/G8cOnZBgucl9OHH/iDCyHO73wAbdVWQ==
X-Google-Smtp-Source: AGHT+IEoptJJiiO82/xIQ1TwCabHJ1T7Vw4Y5buf4f8vVtUjY1bSUZC7p/lpd/eTDyRD64gcyWexIw==
X-Received: by 2002:a17:903:8d0:b0:20c:ecca:432b with SMTP id d9443c01a7336-2129f686071mr172116795ad.35.1732518273489;
        Sun, 24 Nov 2024 23:04:33 -0800 (PST)
Received: from [103.237.87.171] ([103.237.87.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dba5920sm57731085ad.107.2024.11.24.23.04.32
        for <linux-erofs@lists.ozlabs.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Nov 2024 23:04:33 -0800 (PST)
From: Teri Olson <bmhyasin@gmail.com>
X-Google-Original-From: Teri Olson <terrolson@hotmail.com>
Message-ID: <629168b99d4dc378b3faac9b87e173c3d8b6876fed93c74561ac47b04ab40be8@mx.google.com>
To: linux-erofs@lists.ozlabs.org
Subject: ` Piano `
Date: Mon, 25 Nov 2024 14:04:32 +0700
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Spam-Status: No, score=3.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
	FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.0
X-Spam-Level: ***
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
Reply-To: terrolson22@outlook.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hello,

I'm giving out my late husband's Yamaha Baby Grand Piano for free to any passionate instrument lover. kindly let me know if you want it or have someone else who wants it.

Thanks,
Teri
