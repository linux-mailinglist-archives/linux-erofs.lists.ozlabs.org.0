Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3329CD602
	for <lists+linux-erofs@lfdr.de>; Fri, 15 Nov 2024 04:55:04 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XqNSv43mQz30VJ
	for <lists+linux-erofs@lfdr.de>; Fri, 15 Nov 2024 14:54:55 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::334"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731642893;
	cv=none; b=V9WGbaPYkKhCMnWF9gOeSC7up4Tsh0shOtioHGtVNVLcu2xkqmCyXkUSHNDIgNdnFP3Ch/LYvYgoGeKZAIsNodZ0pQCO3drRZ+AQCfCdfvh0gttu56zu+La5Rpb7u5/P4e81A9RiCSjVcWEZG07knkJ1hWO4dxhQTUtB2rTAgqe5pwMBDMBVbZDEl8tc0bjg5W1ZUWgNfI2MBsvwfZOeHxt5uaaLRiW5LT+/s4NuyPGYLhAE7PnJoUtCqt1HDx+UOH11SHzuUyXOWGTVF8v0pEDJwOVpqSQ9K1xHRtwKbM5kFjYXtYifHkPH3wEPxV1gVuJjKwkz4RDCtofinEfu0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731642893; c=relaxed/relaxed;
	bh=mqk98GP19dZ+Ay7HEP68kLZER2bT/NkIqYTu8jMJ4BE=;
	h=From:Message-ID:To:Subject:Date:MIME-Version:Content-Type; b=o2g6+9U6SXwByxOVIpR3cNVG7qwuq8xftV7xMM62sUBrLwnVi+Bco/hGhf09TlIkRfULrV7eU+zNK0m43f4e1o19k9qrCPFUbMZi198mvzEnjkkTRmW5AzlWLyhpf74DKwqVy0l74j7MyayJP5BZHyjfDNCd4Vx6Dkj2VVx7lL+0bTaAbre+chY1jyD3N7232/6Gige+9gMb829iG0KowAMXelhpIvb6PvDu00dixQcFfH3PZQsvyPxKE9el3o7tckV7GdtqXZ9M6guKVe6+CTjEplvrSFg2x0lEOvP4Z7/WHBAaWx79iREg15cDkqbKElv8FNHZbjFGW4fkXGxyQw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=aA1X8JtY; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com; envelope-from=rahulsarkar7433@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=aA1X8JtY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com; envelope-from=rahulsarkar7433@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XqNSp6xChz2yQJ
	for <linux-erofs@lists.ozlabs.org>; Fri, 15 Nov 2024 14:54:50 +1100 (AEDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-43158625112so12174565e9.3
        for <linux-erofs@lists.ozlabs.org>; Thu, 14 Nov 2024 19:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731642885; x=1732247685; darn=lists.ozlabs.org;
        h=mime-version:date:subject:to:reply-to:message-id:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mqk98GP19dZ+Ay7HEP68kLZER2bT/NkIqYTu8jMJ4BE=;
        b=aA1X8JtYL1pwYALzrLPcr5buBmcjqRuMnhc1OxT7UlGmji33FkGjd+/8vVHguz7HZd
         LHgRC9E+IoIqz1s6mbeYlO6TnfVb790a7VyV7EinPPYt+SgOecckF5eCRD8L1t55A0Qh
         VrHo6Xmd89v7q4rbtOdnXA31XctTDyLts6F/gy8arN92gzgoEFOWzw86XHBzXL1ezesD
         WpTD8CLYScpdrDQ+o0tDXVuCx/iRdAF7e+OkbQw2tfMjM3Yw8JPcqU3Q4g6c0N9iWPQi
         ex+GgG+UB7QfhVnzSOXPa9dpEDID/JiQz5us7a3fiksPdjQmWYvyjaiazbomRvBPEuSi
         HiSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731642885; x=1732247685;
        h=mime-version:date:subject:to:reply-to:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mqk98GP19dZ+Ay7HEP68kLZER2bT/NkIqYTu8jMJ4BE=;
        b=CjF12AWVNq+PILbcMnNTj/Nw3JnzizwpfIqeIXs1E5PZUMgt4hG6bD2w9m+FVwBPK9
         R4H1ZH1AMfdiLDmoUbFIxbyueEHKAFqEpNChYJMvOCjw4D5dqWygZRqyXZ8Na9HYw5VG
         3sY/lCZs5GtEt0GuDP+c/SpeGyqWR/NPTPfLDQWzE/8TEGh5b1HjmjQlztPx5Ip9k/gR
         TZmWbkYfBNTYUmsOPXCR34vXsKN78bINtuc5fiYSs+jkDVnin34dFYHe0C8fsubOcGk9
         1e/XSYHgbdv/gFDbEmiXUiWrBd7KfcxaLIgkq05EAMCccE2RaihR5w0U2Y7JQnujQsFX
         FweQ==
X-Gm-Message-State: AOJu0YwCMPgWgoz8/Pi2BwSqLC2LP+RgfPyT7kaYzsIjcbo6ZVJeYdsh
	L9g5pNsjvEneuxXgNJ+dgKegxo+vIeubXUuOGliprr90BCQk0HwTKseIig==
X-Google-Smtp-Source: AGHT+IEiJW349fjHXMqFMRg0yt3Fq1bxyq7nqq/2QPUZU7Y+lkAph3CqaHn0sBkmLGuoCPZ86k5yLw==
X-Received: by 2002:a05:600c:5129:b0:431:54f3:11af with SMTP id 5b1f17b1804b1-432df78fd98mr7912235e9.31.1731642884804;
        Thu, 14 Nov 2024 19:54:44 -0800 (PST)
Received: from [87.120.84.56] ([87.120.84.56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821adadf8fsm3153911f8f.39.2024.11.14.19.54.43
        for <linux-erofs@lists.ozlabs.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Nov 2024 19:54:44 -0800 (PST)
From: William Cheung <rahulsarkar7433@gmail.com>
X-Google-Original-From: William Cheung <info@gmail.com>
Message-ID: <de7fd6b6699abb0ddc1d95ddd95b44e63ac74fdc1bde5822ad0577f9d9541878@mx.google.com>
To: linux-erofs@lists.ozlabs.org
Subject: Lucrative Proposal
Date: Thu, 14 Nov 2024 19:54:41 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Spam-Status: No, score=3.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
	FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.0
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
Reply-To: willchg@hotmail.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

I have a lucratuve proposal for you, reply for more info.
