Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 341F068B425
	for <lists+linux-erofs@lfdr.de>; Mon,  6 Feb 2023 03:24:07 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4P997902gVz3fDL
	for <lists+linux-erofs@lfdr.de>; Mon,  6 Feb 2023 13:24:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=byfKP8/l;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=byfKP8/l;
	dkim-atps=neutral
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4P993V70dPz3fBQ
	for <linux-erofs@lists.ozlabs.org>; Mon,  6 Feb 2023 13:20:54 +1100 (AEDT)
Received: by mail-pj1-x102b.google.com with SMTP id o16-20020a17090ad25000b00230759a8c06so6930077pjw.2
        for <linux-erofs@lists.ozlabs.org>; Sun, 05 Feb 2023 18:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pEQCtfMR+5dSwpbJDOXVU+mL5V7BhUb0kLAyubaJajM=;
        b=byfKP8/l8keSImq7cnPLHDfCjptrupPzRTdCSPragJoRB6+5ClO0TECnkAy2rMYlJk
         FlBRjkITtH0gwPoMeAxeyRfdad8hR62ZbQR6DztzYsYLOXx84UEGDaEuC+kRuzJa0i5f
         21AStq2ftGTz2s7zshbWzNmlzQP/BIdq6PQF8dMN5X+j/EVxRtPVjuDKtUH7hJAjCmd/
         IOEFYp14DrCpm3w9CPQvpkwkpLtUBjudf5XnuHPPcVuiJEv4WKGeH1A8WO2APxGT37Jq
         +y8r0PNAU13wfHxVlWiQcaMemNp44EFLu8cfAOx06xealKO+Jx1Ov+qRe3X6UY3jSMh4
         EOlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pEQCtfMR+5dSwpbJDOXVU+mL5V7BhUb0kLAyubaJajM=;
        b=ZgZ21cQvlbkNYjttSbvYm9mkUIKT66ZWuOWDwG/GXW+47SIm+baM1vyqxeTYM85hOc
         Uk+qdS88v7oF+MY6qd4dKQzXAs9m8HvMiulYhrfsMt2ucuKxrWqsgxnlPtvnd2CgQT71
         QAKCdG0Bw01Pz2pqeFncS55azOLVONRC92aHG9r38H+vkjat4jrjdrr5XvzcD49h3YyT
         nZADlVlEazi9q9sC16ssBydmTrmWnc0wRQLXQMX+L0laS3Rp15DimRZQUo9EUhmK3xrb
         iu92Yn5gia1CM1UXtqWKjKFgFlwt3CbgNSIbbvLKyH3pqeyNXA3LOV9pZtj+UHp2T14E
         R/HQ==
X-Gm-Message-State: AO0yUKWw0yVCFbz21t/YxmI/rNhZiIs7kYZkDbaw4BFn4iSh7KMfZ/Cy
	ZPKhATEa+jP2GmGqnA9KXdk=
X-Google-Smtp-Source: AK7set9wViMZiXUdECyYWP2h029GD5rzQpoJHF8LBMhon7pJWwMxw44tNa17TNTmVYONcK1cou7Yqw==
X-Received: by 2002:a05:6a21:33a7:b0:be:a9c7:5d12 with SMTP id yy39-20020a056a2133a700b000bea9c75d12mr25029561pzb.18.1675650051794;
        Sun, 05 Feb 2023 18:20:51 -0800 (PST)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id b26-20020a63715a000000b004784cdc196dsm5118713pgn.24.2023.02.05.18.20.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 05 Feb 2023 18:20:51 -0800 (PST)
Date: Mon, 6 Feb 2023 10:26:31 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH 6/6] erofs: tidy up internal.h
Message-ID: <20230206102631.000044f5.zbestahu@gmail.com>
In-Reply-To: <20230204093040.97967-6-hsiangkao@linux.alibaba.com>
References: <20230204093040.97967-1-hsiangkao@linux.alibaba.com>
	<20230204093040.97967-6-hsiangkao@linux.alibaba.com>
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
Cc: LKML <linux-kernel@vger.kernel.org>, zhangwen@coolpad.com, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sat,  4 Feb 2023 17:30:40 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> Reorder internal.h code so that removing unneeded macros and more.
> No logic changes.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>
