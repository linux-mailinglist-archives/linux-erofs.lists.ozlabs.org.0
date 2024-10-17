Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B42CD9A1C9D
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Oct 2024 10:10:12 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XTgVn6qGRz3bgV
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Oct 2024 19:10:09 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::92c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1729152607;
	cv=none; b=GQp2yXIntpCApZfxgxRme5ndrq1WEWoBkic4i9rQUMWYxAu9q4wSf5ryi+G0InQHRyMVaEZXgME/aEDCbPx4shp6X9qVEe5HvkdGolewll4f2vcHW1r641S+hDGIzOidCnKUCwE+OoqOKFf4DYD1BzX7RTPHqjcCG1W/y9LeNCO8Yuel48q+TWF6ncul9jHe1VPe3IHhjBmX7rfMI9r/QTzSndD7BlInYaQ8wpTfSmPxY4qOpiVBZlR8/lF/6m+nG6LSq7vHs6Kkn8mCOXCwBnoHdeHMg5Z0SZNNs/VEK+n/c8ukkUYVlNTTJnCFFweFY3EnzXGYpTH/RFke4vnScQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1729152607; c=relaxed/relaxed;
	bh=n8c5tm6n2wtjd6JrCMcUul2FDzsI/PMwtNrX3yN5czk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PSC9Y2XwdYGWfSehxj2ufpj/j3qKX0yBwvEBmlEyvh7qoHjs5kNgIjdW2i+5W7pStfXJeI4USn7aiGjdb44mhw1wnnhpSpLjd7zXy4xDGpJYfa6EKB73+OA5+tkyn6F7vmrtb39Igk+AFnXlzmQXktmyFQnRbeuW6rLukmyqAxhOuwTKW2/3LO5IJldRWO0UazWJ1Acck3QtCK2/qQ6Bx515AGEF7QyIBLuQkwOq1zqPYwJ+WvUFZqP+jSGLjviMqT9KtmwVv00lEalMwDoYMk9nxr95wYRUSa9vNgZNRvDAJ23nLeSXigOpxfkzfRTZH/2806Lsv9v3VO9ew1yMag==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=i+vQY8sc; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::92c; helo=mail-ua1-x92c.google.com; envelope-from=21cnbao@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=i+vQY8sc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::92c; helo=mail-ua1-x92c.google.com; envelope-from=21cnbao@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XTgVk1kmMz2xYw
	for <linux-erofs@lists.ozlabs.org>; Thu, 17 Oct 2024 19:10:04 +1100 (AEDT)
Received: by mail-ua1-x92c.google.com with SMTP id a1e0cc1a2514c-85019a60523so231298241.1
        for <linux-erofs@lists.ozlabs.org>; Thu, 17 Oct 2024 01:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729152601; x=1729757401; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n8c5tm6n2wtjd6JrCMcUul2FDzsI/PMwtNrX3yN5czk=;
        b=i+vQY8scrm6bQep3sQLHBX2pnMruhbnkyPjh3kmNtykrfBPG4pBaxKAIjyW3jLKCDp
         ZaQVpxtjwD4jE5dI6W1MRMibJjQoN9shhnDJUPjI/2aOIqFFpz3UchGMVx3Cv5Flex1a
         DcnVW4v1S72P2Fcub2ASn4TBM0/W/Wy0diA44q0lctNj2eU3+lh+ZxkiWxnktm6xes5e
         mG6tkibMj8fW31LUHHCM52w+ic0Joasiw1xtR97QDnPNdPcQIF5cFz93U7r3klw7qTbW
         htWB8YjS8lFC/VTRM86JFQ5kHaHZMe1e5V9M9H1uRS6/6612yaHBRRxt+3/keDxe5wle
         Nk/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729152601; x=1729757401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n8c5tm6n2wtjd6JrCMcUul2FDzsI/PMwtNrX3yN5czk=;
        b=VA7rHJKcMCFwf5ObO4HEQlZ6rXGNgTCsQ6poS+Q6BFEAHTtf7nYcBZiC24dOKe9CKo
         CHIa1uy/Q3qtZrngTSyuUQFQ90T2gJt7VuQJ43o51ephG0eLPXcrsxpquXgF7/Fohp7l
         Z9ec+XUvULkdZmVw/obD97oJDapTy9io2tnQoRqTw8dBnSXxDmHJ5aAcQ3QkXP0+Um/V
         DBhKvCsY7GAr0WY50APkqy/bntDQH7kAgZ0wG2ajvVSGrYMPC234RXC/jaDUJsjASO2F
         x/HjDAqrT9T+er/lhc118G9PTovr+svkB5Nnu4OYJub1GYoc2zHt0jev7xoPz5hNsulC
         ueiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWF1ZoP4qxA1ltK3MwMq0xxc5d43Pau27TPqwOYUFFktwshoqdSPuEuqPkhbb8I2IztgSWocG69q7/AxQ==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwguBqYKM/sR4cwudu1FtemGTtk5tpraOG4dNBKBsue2iEHzcLv
	/AyG7Oo5VSLlGetcmWmZGbFkI3hiS5MqwnQwNGIeeVB79+AIzySMtJOX/ZQho84tzlTWII5meTi
	s1GDjvOhT54OkdJmZgcF1X/4uHvg=
X-Google-Smtp-Source: AGHT+IGTUtrvSTVPF7UC5Y2BiQUaC3VS/XZL2v9NMKQB4jPDSExZQ2AU04U5a7BbGXBYtBk7rmGLfoW4IAtl9cGzgTA=
X-Received: by 2002:a05:6102:54a5:b0:4a5:6f41:211d with SMTP id
 ada2fe7eead31-4a5b5a6fddcmr6397469137.24.1729152601057; Thu, 17 Oct 2024
 01:10:01 -0700 (PDT)
MIME-Version: 1.0
References: <20241017074346.35284-1-21cnbao@gmail.com> <ca27aa75-40a4-4c82-8d84-7968b2ab89d4@linux.alibaba.com>
 <0fa18bcf-9af6-4c99-ad57-613fa38ff741@linux.alibaba.com>
In-Reply-To: <0fa18bcf-9af6-4c99-ad57-613fa38ff741@linux.alibaba.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 17 Oct 2024 21:09:48 +1300
Message-ID: <CAGsJ_4yLK3sCeJNdZRKxD2tSdMVFRBp9eq-1mAMu7UT=gqpA_Q@mail.gmail.com>
Subject: Re: [PATCH RFC] fs: erofs: support PG_mappedtodisk flag for folios
 with zero-filled
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.0
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
Cc: linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Oct 17, 2024 at 9:00=E2=80=AFPM Gao Xiang <hsiangkao@linux.alibaba.=
com> wrote:
>
>
>
> On 2024/10/17 15:58, Gao Xiang wrote:
> > Hi Barry,
> >
> > On 2024/10/17 15:43, Barry Song wrote:
> >> From: Barry Song <v-songbaohua@oppo.com>
> >>
> >> When a folio has never been zero-filled, mark it as mappedtodisk
> >> to allow other software components to recognize and utilize the
> >> flag.
> >>
> >> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> >
> > Thanks for this!
> >
> > It looks good to me as an improvement as long as PG_mappedtodisk
> > is long-term lived and useful to users.
> >
> > Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>

thanks!

> BTW, I wonder if iomap supports this since uncompressed EROFS
> relies on iomap paths...

In the core layer, I only see fs/buffer.c's block_read_full_folio()
and fs/mpage.c's mpage_readahead() and mpage_readahead()
supporting this. I haven't found any code in iomap that sets the
flag.

I guess erofs doesn't call the above functions for non-compressed
files?

>
> Thanks,
> Gao Xiang

Barry
