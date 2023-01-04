Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC12B65CDAB
	for <lists+linux-erofs@lfdr.de>; Wed,  4 Jan 2023 08:37:49 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Nn1fM4V54z3bTJ
	for <lists+linux-erofs@lfdr.de>; Wed,  4 Jan 2023 18:37:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=p6zezupJ;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=p6zezupJ;
	dkim-atps=neutral
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Nn1fJ1hpFz2xH9
	for <linux-erofs@lists.ozlabs.org>; Wed,  4 Jan 2023 18:37:42 +1100 (AEDT)
Received: by mail-pf1-x432.google.com with SMTP id e21so12667332pfl.1
        for <linux-erofs@lists.ozlabs.org>; Tue, 03 Jan 2023 23:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aEPwp+YJt1cYaX4eWNYoUeZeo0T9wPGDCgE5NujouL4=;
        b=p6zezupJveExX5zHj8/7cIR4fJDEcdP/RC1qJO9yPZcc2A3S+H2W50vGDkUqg89/I3
         uVAoR2QqVfnHQEnYPBViGYhhRLLxVSVHk/rm1TFOjxXOR0mVuFlDHNsOb2BNfrOL9v0S
         fVoF5gjmU1UvsoA/BOgoe78g2KP8c3TDvZY/WuJyiZB41D0iBxDI0hmS/IqV0FamUFC/
         PLP/+x4DXruTcJJ7UD2K4iRXdmOo0KUGJXrPwoVrKIEF6tfl5V6HkEHDRXz1F396bmZo
         3Ojzwz4jPgRj+FvNwcl4G7DnXHip/T6OhAf93UtJ5LDMni+ap6RH1EA1rFx+HLdw1mjE
         gXQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aEPwp+YJt1cYaX4eWNYoUeZeo0T9wPGDCgE5NujouL4=;
        b=oICXcaJezcZmkVkIhsCVAfHW7xmTu9OTdr1A05UV7khrSFpSizzz2DJbwWbvIkppMs
         qM0jscIwWx7X119GJ1R9Al07j/qFvSC61X775Zw1ndYjkDuw/5VrTC6q6moXJB4oWdxu
         HIjj8Siei3kx/M+sPbhgsFDgjySzaSnF5syv/RvNGCdKRAoEn1YFYuOznJgHnsOZY950
         wltp8UzWarueeRcul6bI5+Y6CiBZ6XJx2s1txj+UuWICh9SFz/jGPBKw8E8KQZWC3nhJ
         r/uNkHoBLIGpbCjUL0t1tnEtROeekDy3Noh0kl+27sMWkULlJHslp1mgehd1A3+iwAGj
         ijPA==
X-Gm-Message-State: AFqh2kpYBwMmDBkH6aUo9VElEXqkRlvlzHdECToIG719JEflZQ0jO+O5
	Ohv34Bj2NgUmyFim9BMQ/flTUGpIGNw=
X-Google-Smtp-Source: AMrXdXvofTmVXXhARv9bVK2E3wYzyJl+/25l+Hf48ppJY+1EJZ3sZRlCKI7HnRKVLzorAWmzM2MXUw==
X-Received: by 2002:aa7:8658:0:b0:582:e4fd:bea8 with SMTP id a24-20020aa78658000000b00582e4fdbea8mr2303630pfo.30.1672817860457;
        Tue, 03 Jan 2023 23:37:40 -0800 (PST)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id b10-20020aa78eca000000b0056b9df2a15esm16251400pfr.62.2023.01.03.23.37.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jan 2023 23:37:40 -0800 (PST)
Date: Wed, 4 Jan 2023 15:42:38 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Xiang Gao <hsiangkao@linux.alibaba.com>
Subject: Re: [RFC PATCH] erofs-utils: fsck: support fragments
Message-ID: <20230104154238.0000169e.zbestahu@gmail.com>
In-Reply-To: <99d24ef5-c72a-80ea-9ea5-2b7e1e60af79@linux.alibaba.com>
References: <20221224094319.10317-1-zbestahu@gmail.com>
	<fa1df3e5-9158-4381-5315-d243f77542a6@linux.alibaba.com>
	<20230104112445.000075d8.zbestahu@gmail.com>
	<5236b19c-763f-9a5b-a0c1-4c59fa7c6d05@linux.alibaba.com>
	<20230104152651.000051df.zbestahu@gmail.com>
	<99d24ef5-c72a-80ea-9ea5-2b7e1e60af79@linux.alibaba.com>
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
Cc: Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, 4 Jan 2023 15:28:42 +0800
Xiang Gao <hsiangkao@linux.alibaba.com> wrote:

> On 2023/1/4 15:26, Yue Hu wrote:
> 
> ...
> 
> >>
> >> I think we could just export parts of erofs_pread() to clean up the
> >> whole erofs_verify_inode_data()...  
> > 
> > What's the clean up referring to?
> > 
> > However, i think erofs_verify_inode_data() looks a little duplicate compared to erofs_read_raw_data/z_erofs_read_data().  
> 
> We should reuse the main part (for example, by introducing an interface 
> to accept mapping) of
> erofs_read_raw_data() and z_erofs_read_data() to avoid duplicated code 
> in erofs_verify_inode_data().

Yes, it's. Let's do it.

> 
> Thanks,
> Gao Xiang
> 
> >   
> >>
> >> Thanks,
> >> Gao Xiang
> >>
> >>  

