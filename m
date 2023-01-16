Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2489366B5A8
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Jan 2023 03:42:22 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NwGWt4Pnyz3cB7
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Jan 2023 13:42:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=gsgZmqMm;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=gsgZmqMm;
	dkim-atps=neutral
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NwGWm4GMvz3bTM
	for <linux-erofs@lists.ozlabs.org>; Mon, 16 Jan 2023 13:42:10 +1100 (AEDT)
Received: by mail-pl1-x62d.google.com with SMTP id p24so28903138plw.11
        for <linux-erofs@lists.ozlabs.org>; Sun, 15 Jan 2023 18:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HzasTk/Ro7CO00la7hcoLrNg4yRWZdF8WTiKUq6bM2k=;
        b=gsgZmqMmSWpWo4TZWVpQ7aNVLgCxuLy/SkYvwEYhUIvKED2TfSsQh+9uJCE6BOVSZy
         zpd4A4GAXOBgZ1X5IdCugq6WxRy+o/STLIvHvZSYGfy8sUaB8fkYekWRiBHK1D44np3/
         J5wlCPXHv0iaTl0t2q5Ugojxm9f/4s7ckBGyxGW7jQ1v0dyj/FEpIfTayxOl5h3JofeY
         zrjJPkjJANMikWmeuzHy905F15uYA++3phaWo5IAcOssKwfyslkxficFC3DCZQTVX6hN
         2gAlgUt+ZIobE9Q7U1rjTH7E0Jon3zulUVdU90gR0MZgecfocWZatA3kmfOl3IlpXISD
         SMdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HzasTk/Ro7CO00la7hcoLrNg4yRWZdF8WTiKUq6bM2k=;
        b=P3o3ZkOXcIZiwXcC08FYM65ekT+XMXsRP6CWPzNycpaNzEI9kCjN3NkeQ7KAS6zP6B
         FaDXqYVJWrPVfrTHZPyji3AnUaR2ImR72w4mgSOKIl+yDK5V1x2r6la/kTBU7dDKht/+
         4yF6PEaj50eF//88/VWNtEMXHLv/ZNLlZroleYTNzEMBSoQYhGQ1XyenbIRs2o1vr1Xx
         40V3DDXDjbxRRi2i4Gu0MaRbhqtLnqyEl/mXA9JrlFVoRV8oJnr3c4nRqf8AtKIWJNgq
         AXLrPAALfR43+tXjwYQwc/ZlB8EnN154oAvb2Oh++ft8Yj/nfnU0s0epDzeEM9yhyhOr
         +nxg==
X-Gm-Message-State: AFqh2kqNo/6Q8WFAj65rZHEih5GwQWOccNQMFMdB25MV8kV9ZTCZfrmR
	1YKn+QSk3MHqHmobAJ7RrzaT/6bsH9M=
X-Google-Smtp-Source: AMrXdXuKjanSCUOEr1Oui8au3I3YJcM2uFAcKpKAJErY3jfUtwiZYKOQLotkiJnAgNR30bW5ip3bhg==
X-Received: by 2002:a17:902:9b97:b0:193:b58:2b0c with SMTP id y23-20020a1709029b9700b001930b582b0cmr29244471plp.23.1673836927675;
        Sun, 15 Jan 2023 18:42:07 -0800 (PST)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id cp5-20020a170902e78500b00177e5d83d3esm18051232plb.88.2023.01.15.18.42.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 15 Jan 2023 18:42:07 -0800 (PST)
Date: Mon, 16 Jan 2023 10:47:22 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <xiang@kernel.org>
Subject: Re: [PATCH 1/2] erofs: get rid of debug_one_dentry()
Message-ID: <20230116104722.0000405d.zbestahu@gmail.com>
In-Reply-To: <20230114125746.399253-1-xiang@kernel.org>
References: <20230114125746.399253-1-xiang@kernel.org>
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

On Sat, 14 Jan 2023 20:57:45 +0800
Gao Xiang <xiang@kernel.org> wrote:

> From: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> Since erofsdump is available, no need to keep this debugging
> functionality at all.
> 
> Also drop a useless comment since it's the VFS behavior.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>

