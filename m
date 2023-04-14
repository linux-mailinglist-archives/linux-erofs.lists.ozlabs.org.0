Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 973DA6E19F5
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Apr 2023 04:04:32 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PyKWZ6jC1z3cJq
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Apr 2023 12:04:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=GbNAMYG0;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=GbNAMYG0;
	dkim-atps=neutral
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PyKWV62DTz3c6Y
	for <linux-erofs@lists.ozlabs.org>; Fri, 14 Apr 2023 12:04:22 +1000 (AEST)
Received: by mail-pl1-x635.google.com with SMTP id p17so5832881pla.3
        for <linux-erofs@lists.ozlabs.org>; Thu, 13 Apr 2023 19:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681437857; x=1684029857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jSeMJSB+1OwVk7zbF+vhVDfhbKvf9MjEEZ5KVFwlsd8=;
        b=GbNAMYG0e+ZTkBi0pfWkHDO2l22kbpu5C/Hh+zyMkkdZ7fveDWmRSPP4srC3DLdxt7
         7SKCX6KbgwuJJph0WxS1Kvwgr4ANRWNCw16my/6B/dG2y4KtOlk+ivf1Eczug1JOKlCC
         tua8eu4/V33cYHxN4TJQM3AAjAWTDx7SvZgqfNF1zgaCaC1msnVn3G/UNdtjlOodnTlH
         b27AltOSoVwxtlEpHcUvU80pAPyPFqQO/G/epj7Tr99nUe/rwf+ah1uIAcD/3zaFXRoQ
         fc142BQ/ynQfpwvmPBxVuhxRixH8lwPhjoYlqpyI118LS7MbrkdYx3ZYi73iJNTlcmNz
         Yf3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681437857; x=1684029857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jSeMJSB+1OwVk7zbF+vhVDfhbKvf9MjEEZ5KVFwlsd8=;
        b=YdG9LJTfB0dZNOcAtaiCEArX7GZMdYNdAzsBo0h/bpLo7Y8NSEN+FuymcwCbfJC9vs
         CzhU5C+WBOmarWrlKQ20uR4Y+wOpUuTBUBTSsOALdKpLf3vtB2ACufaO7p2vmg/aID4i
         0Kb00F0qC40mFqJRoVwCFHq/sWCbHMuQVttMiQFJhOorDrw7snvXCF4wMoiO7mmRusIh
         5VSScAypTnB2Pjd/8GYFpGye1GBFfEzMxmy9O/Q5AcvUVG4BB9xi9Rn+KlfEjDT79dM8
         FJMyH3z0txGtZnJZ2wrtg/47vsqxH8Oq1De7HIJroQ2+U5TpF9G05E44QrJsIve8YoTc
         5bDw==
X-Gm-Message-State: AAQBX9e2PUxEyrn80OeykIMsWRJEnR5lMA5APf29GuydoT3baSle4IB9
	eZDctd6linprYqrRljnsqIE=
X-Google-Smtp-Source: AKy350aOhc4mA5KYzyXboebEAY7znLoio0fCpKQ4kpxPsM+7QpzUr0wlUp4+aDQmNrV4QCWoZrYJWg==
X-Received: by 2002:a17:90b:3a91:b0:23f:7d05:8762 with SMTP id om17-20020a17090b3a9100b0023f7d058762mr3592951pjb.23.1681437857632;
        Thu, 13 Apr 2023 19:04:17 -0700 (PDT)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id d21-20020a17090abf9500b002470ce35621sm1927374pjs.20.2023.04.13.19.04.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Apr 2023 19:04:17 -0700 (PDT)
Date: Fri, 14 Apr 2023 10:11:26 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH v2] erofs: get rid of z_erofs_fill_inode()
Message-ID: <20230414101126.00005a93.zbestahu@gmail.com>
In-Reply-To: <20230413092241.73829-1-hsiangkao@linux.alibaba.com>
References: <20230411101045.35762-1-hsiangkao@linux.alibaba.com>
	<20230413092241.73829-1-hsiangkao@linux.alibaba.com>
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
Cc: huyue2@coolpad.com, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, 13 Apr 2023 17:22:41 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> Prior to big pclusters, non-compact compression indexes could have
> empty headers.
> 
> Let's just avoid the legacy path since it can be handled properly
> as a specific compression header with z_erofs_fill_inode_lazy() too.
> 
> Tested with erofs-utils exist versions.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>

