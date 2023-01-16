Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A40D166B54F
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Jan 2023 02:47:23 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NwFJS6fKKz3cB1
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Jan 2023 12:47:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=TwWHWle4;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=TwWHWle4;
	dkim-atps=neutral
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NwFJJ3l0wz3bVZ
	for <linux-erofs@lists.ozlabs.org>; Mon, 16 Jan 2023 12:47:10 +1100 (AEDT)
Received: by mail-pj1-x102e.google.com with SMTP id z9-20020a17090a468900b00226b6e7aeeaso29670259pjf.1
        for <linux-erofs@lists.ozlabs.org>; Sun, 15 Jan 2023 17:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wSr3gBths7LfzOhP3PbG7HoBbxP6OSt6Z7HOZ0qcxXo=;
        b=TwWHWle4nENJdybCYfEUNwLATVa6lRfDW7SUhskQ95K/FfJqRCxcpHsjnb8fHepDs8
         1H8Ip6lJBhjX6JltLk6pklRUbaTjjszDDOqQXSO8TsrzN9DwUdegliA4X32DNzI7hShX
         rV+rwfcCTSFburVZXA7WhwVyh9JnbiP5oIdOZje8pxNdPuhFs6O+ANhtM5Rkfx5ypmNg
         DxrjchoXVuZ4jd8uTRWPyYVfRriANi/YcZVLPg6ENVyHHOAHkJSshuvqEcaSIT/XKJW7
         ETfIeCoBSybkec9vWxEDmku/0mfWX5D1RR9k169/oUB3lPxAWE+SPJ4DUWU0ChJHvmCw
         WPBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wSr3gBths7LfzOhP3PbG7HoBbxP6OSt6Z7HOZ0qcxXo=;
        b=EoWH2nZihiebntSQGTyderV+z9wyYDm0yn2uCkUTZ48wjhh237v2VZJTuTF+AXHf/p
         0BEc2LzGp3z9DPh9jksv0EssD9sd4m0buNO//RNwrEGm49KyQeqhVZdHC/GSDtfq1Lh4
         HxGWqC+5ZokQILt/GKM0h5hdRemMTD58AsOgJCSYuXxYTcCkFk+dzNEnkKbm0Z6HxeXJ
         UYvC08MJ4I9+RHNHazKFawnub+Q2lZVMeQb4vAx9gT/ijz93AToRipgd3ETLquVvz4g9
         MMY7aHFY/tOEduSlSLG7tD9RDbt9ugQaHmwIrTwbBFoX/3PCqeTQ9VUbhsQewkueTPIl
         Wvdw==
X-Gm-Message-State: AFqh2krYcDddfLo+jDQduvEra6ZUAR8BmS2z5V6XuyOEBuvSMTyzsAtH
	N7XgsHycgCUoePaztQBNvpc=
X-Google-Smtp-Source: AMrXdXve+Ct7yuT9wUiewycnlfGeBeR6Y20nXR/DrHTnfkVDxHZul7Xv77WqoccFtvZBdleBCVHn1g==
X-Received: by 2002:a17:902:eb11:b0:194:46e0:1b61 with SMTP id l17-20020a170902eb1100b0019446e01b61mr20978703plb.63.1673833626434;
        Sun, 15 Jan 2023 17:47:06 -0800 (PST)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id b13-20020a170902650d00b00187197c499asm17985883plk.164.2023.01.15.17.47.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 15 Jan 2023 17:47:06 -0800 (PST)
Date: Mon, 16 Jan 2023 09:52:20 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <xiang@kernel.org>, zhangwen@coolpad.com
Subject: Re: [PATCH v2 2/2] erofs: simplify iloc()
Message-ID: <20230116095220.0000093d.zbestahu@gmail.com>
In-Reply-To: <20230114150823.432069-1-xiang@kernel.org>
References: <20230114125746.399253-2-xiang@kernel.org>
	<20230114150823.432069-1-xiang@kernel.org>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sat, 14 Jan 2023 23:08:23 +0800
Gao Xiang <xiang@kernel.org> wrote:

> From: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> Actually we could pass in inodes directly to clean up all callers.
> Also rename iloc() as erofs_iloc().
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>

