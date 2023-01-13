Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B813668F54
	for <lists+linux-erofs@lfdr.de>; Fri, 13 Jan 2023 08:39:29 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NtYG36hQ6z3fB4
	for <lists+linux-erofs@lfdr.de>; Fri, 13 Jan 2023 18:39:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=ak2mIBtm;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=ak2mIBtm;
	dkim-atps=neutral
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NtYG03c5vz3c9G
	for <linux-erofs@lists.ozlabs.org>; Fri, 13 Jan 2023 18:39:18 +1100 (AEDT)
Received: by mail-pj1-x1036.google.com with SMTP id dw9so20203088pjb.5
        for <linux-erofs@lists.ozlabs.org>; Thu, 12 Jan 2023 23:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nem0KGVeWs0u59oN+VKYDUtx5w3BXdJrIOfqnvfQKls=;
        b=ak2mIBtmvgLjfoPMJpoGvFi8qhD9y0nqnJ8JDCF3itBst44IJhPv8whUVxrA5BeEbN
         2mTELUcwuFXFX3H3ZeEf4wljJGbokkEEGkkQ/eNJ8LeuIAVnNl1becbZ4fmKEdttA8Dh
         ZKchQpHg8shcoQ1amIEEGbbom3oz0vMY83dX0knUDLVYbEsCBu9fiaxKYcA3V03O/OXW
         Bg5oqPlKkqJlnEbIrSfcyWNsqXigy49GALRWRaxADMU5w2ZlB1ErDzyLCkeDQNJ/DSI9
         sL6qnvcctsH6Efus2B+NB/3Q3Ry643m7IaNcyyt7iAY0D+Fr782GIJXHx25eEMHcBzFH
         QzLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nem0KGVeWs0u59oN+VKYDUtx5w3BXdJrIOfqnvfQKls=;
        b=BGyeoPfbt2f3GIuP/5Ainm2HjDuOFQI8BUIzmDyM6bp7gl2S0HnOxJQO5Qi4ro2db8
         JldnYR7I7GhEdswl6W+daz3GQupP/RdCQiuoJKD7/Om8QV4GOVFU4kCsWyCKbL8RhHTY
         5Q3TeDm5P3T08BdRI+07J6SAJbycqjrFPQba31arZoZiIgWRFBBEV7jQkiYT1IfKVpT7
         r+HTpHVtsmEKrBo5QLIfh52rx0lVtFPAQ8t+XYALHCAU2LdLQkfQ2Llyp+YXHMugcAUK
         Ks/Tes5ts11SsnG8TMHnRd1tcnBhTyfdvhJBucLoYIelKgqlItsN0Wv7rlrbfy5e7hoN
         KDfw==
X-Gm-Message-State: AFqh2kpZwv0w9AN8SHn4ySCBH/xZR1unfZ6AZrXdxmRuckKHz04OSX1p
	rJkqE7ntoFJhYVWUQtUnB0Y=
X-Google-Smtp-Source: AMrXdXtK4onV1NMvixLT7yn/U/dySVbMGDiBAjiVN+dgrZw6ihHmwHUcpqaY1TB6iXu9+52fEo+2zg==
X-Received: by 2002:a17:902:d587:b0:194:457d:6dca with SMTP id k7-20020a170902d58700b00194457d6dcamr12306423plh.44.1673595555559;
        Thu, 12 Jan 2023 23:39:15 -0800 (PST)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id p16-20020a170902e75000b00186b8752a78sm13488176plf.80.2023.01.12.23.39.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Jan 2023 23:39:15 -0800 (PST)
Date: Fri, 13 Jan 2023 15:44:27 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH 2/2] erofs: remove linux/buffer_head.h dependency
Message-ID: <20230113154427.000053dd.zbestahu@gmail.com>
In-Reply-To: <20230113065226.68801-2-hsiangkao@linux.alibaba.com>
References: <20230113065226.68801-1-hsiangkao@linux.alibaba.com>
	<20230113065226.68801-2-hsiangkao@linux.alibaba.com>
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
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, 13 Jan 2023 14:52:26 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> EROFS actually never uses buffer heads, therefore just get rid of
> BH_xxx definitions and linux/buffer_head.h inclusive.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>

