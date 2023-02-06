Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB4E68B40A
	for <lists+linux-erofs@lfdr.de>; Mon,  6 Feb 2023 03:01:03 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4P98cY54sMz3cGy
	for <lists+linux-erofs@lfdr.de>; Mon,  6 Feb 2023 13:01:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=ioB2zpH1;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::532; helo=mail-pg1-x532.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=ioB2zpH1;
	dkim-atps=neutral
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4P98cT41Tlz3bNn
	for <linux-erofs@lists.ozlabs.org>; Mon,  6 Feb 2023 13:00:55 +1100 (AEDT)
Received: by mail-pg1-x532.google.com with SMTP id 7so7232569pga.1
        for <linux-erofs@lists.ozlabs.org>; Sun, 05 Feb 2023 18:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L5euQeRNKs1Kj9wMLlIQEXGdYJaSH2fOQxZcUhV1cvw=;
        b=ioB2zpH192Kd4Mtg3bXfxT65uqqtiX9vkfwv7RmynFcvuU5RUkSxfAO9BmknROIpKl
         oyQHgCbceZGsZgJgtO3PHlYxF0MT+iKt4VABglcNH7BqfHRBHIAP7LMYdYmVQh0Y84O4
         s3b3WRrzgz/+KPFcMf1jJlDFkEmmd1TKMWj5zU5pXXg5Jbb1wz+AgEAqfDD8nwFrLnWM
         m7GaxTDWeaLs6TMh4ZgCk+lGsedlxlskUyFFvUdk65Xyts5pFJvBt/vq5MNXJgqzsLQ9
         QJYorOPFYogol5lbDlNrtsKMZyOeK7//1j6BHaUSlc7jXLPdCIPIkaqfMAxKWj3I4c9T
         VGnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L5euQeRNKs1Kj9wMLlIQEXGdYJaSH2fOQxZcUhV1cvw=;
        b=V9J3afFp1ROsCrYnIc1xhoqAcoB3RuLW6W+TTGyYhvzxJXLgcRvli3qPKvySme+mBQ
         Dm8Clydljo1Fvy3UAYeUYy1fVOGQ2Te+4PC2ZVpBOSMRVgFTQRvKN2IHHO9HK7j8lOFP
         HadO/YwGOyRS9SRiXdDfse4nUZ/LC5Eah4xmGEqA1Uv4GKbZDeXvYBM0wcIzbLqQY4pw
         Fx0R+szs48m3NojwxfgV8fD5rqljNCyaMfk/728i9m2lQATpOcysb9/3vQWWFh302y6Z
         fc+bfhVWG7EKkZO/lVMED2z2Z8ioQlF8pf/5P/mWW9NWBlWCKrO6X/pLCJFbTTs/yD4h
         KFrA==
X-Gm-Message-State: AO0yUKUw90Sy7m8ftx+ajFKxopBl0SqyOZrJSi99zW1d8cGJolqBMEmC
	BCun1XA4n6aoS+D+8PBfdns=
X-Google-Smtp-Source: AK7set/sOJACxrV0+v1BUMxEo02CyoaMpWmJoTjNPHcAQluzTvSiouru/T7TKykj1JVOEHJpaHCxTQ==
X-Received: by 2002:a05:6a00:23d5:b0:592:629a:c9b5 with SMTP id g21-20020a056a0023d500b00592629ac9b5mr21066957pfc.14.1675648852506;
        Sun, 05 Feb 2023 18:00:52 -0800 (PST)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id y126-20020a623284000000b0055f209690c0sm5726076pfy.50.2023.02.05.18.00.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 05 Feb 2023 18:00:52 -0800 (PST)
Date: Mon, 6 Feb 2023 10:06:32 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH 3/6] erofs: remove tagged pointer helpers
Message-ID: <20230206100632.00004cd7.zbestahu@gmail.com>
In-Reply-To: <20230204093040.97967-3-hsiangkao@linux.alibaba.com>
References: <20230204093040.97967-1-hsiangkao@linux.alibaba.com>
	<20230204093040.97967-3-hsiangkao@linux.alibaba.com>
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

On Sat,  4 Feb 2023 17:30:37 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> Just open-code the remaining one to simplify the code.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>

