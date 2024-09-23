Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD6997E576
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Sep 2024 06:37:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1727066225;
	bh=/aCOx66mDLjCY2/CdXWC7lFsR07hWbPRUPFMOePtthQ=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=eA/FYAjfj+UtRPm5/fqWYLX4r24UOAx7dLhWXi6T9VmRc7/82KxFFkffigjMNPVIB
	 XGqUgZIeUh7ovAmUzoY4tKLL28OB6Ph9rYO5UPO36u81a8eNYslb1OIAwnsRwq5wmW
	 JXffKAek1jcdsbtGgO9Tm96tBn+VIw9YFeig1AcUKAyOCDLDaeF8KSZO+3n9a0PaDd
	 TWdBZNFrH8T5ydbdFc4NSS0nF5zSWCcEOyArejeCUW2NtLoyEMLEJVlz3fkmcbJUhO
	 MVRhhrG+ax9nMN7koBClbJfg1DxpSwdSsZQMP9spdB6vShz2TE2wpDAYA/EPBpy7PJ
	 PLIEWBYE5LPVQ==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XBqw12091z2yVX
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Sep 2024 14:37:05 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::434"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1727066223;
	cv=none; b=nbaVJxIP4jh13GwOQVGlthPrcAbqlSN08H/UyeYd9UqkoTK5AtUdM4WB4IdMUPgp9+iNQKyjHx/AiPWcYB+klMW+uuCOOXQSLHTj/JHN6Hq7lTzt8RXoj6VyBh0SEQTmzHCy8GJDTNxqXYYKxcm93WBpyw+gnp/W7gWF3nhfRfUcbtf/Ua3oVdyJk1jwWm7Dck5fPOvR072oRTzH3jBwZZEMoYy8S083PRz4YfV27GMAbTOdyklM53Mn/fZBVDsUWP89J3j3vk8VGVJcrBp5nRHjC/TXCXQpG2vXb/tuDZkv95PGgOnJqLv+FBewRdEzk8jirz291xaYSS8O+jtMTg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1727066223; c=relaxed/relaxed;
	bh=/aCOx66mDLjCY2/CdXWC7lFsR07hWbPRUPFMOePtthQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bKOyu58oyt1BjmY/hw1VW21dbKs5ys4mjGDohMDjQEOfCbHxgdWisg++rn+2U4CYks5uVcuB7MAthVJ3/q7eARY2NW41yfQmgrfAmlotb+Hw8LmXcXhyi5p9iQlSfYhWFwIZX5jweDE99WDnZFfwwAZ461J5W/KpV5PvxfWu3Q6XwXruc6JCfendP/9nV49T//OREyKtYzSxTgjAVj2aaRwU7B7kuselxh9zNj36Gqh3ow9NUWpXRA69bB3YIqzABveetSxdK+xn/L6S2xjfp0gfU5UbMHXNc9G6bUleywBWF0bk2YxEQ3LnD0Ee998i8R/g//wzYcR5LKYEJGfyfg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=orbstack.dev; dkim=pass (2048-bit key; secure) header.d=orbstack.dev header.i=@orbstack.dev header.a=rsa-sha256 header.s=google header.b=GJGo4S7n; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::434; helo=mail-pf1-x434.google.com; envelope-from=danny@orbstack.dev; receiver=lists.ozlabs.org) smtp.mailfrom=orbstack.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=orbstack.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=orbstack.dev header.i=@orbstack.dev header.a=rsa-sha256 header.s=google header.b=GJGo4S7n;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=orbstack.dev (client-ip=2607:f8b0:4864:20::434; helo=mail-pf1-x434.google.com; envelope-from=danny@orbstack.dev; receiver=lists.ozlabs.org)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XBqvz2S30z2yNj
	for <linux-erofs@lists.ozlabs.org>; Mon, 23 Sep 2024 14:37:01 +1000 (AEST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-71798a15ce5so3377874b3a.0
        for <linux-erofs@lists.ozlabs.org>; Sun, 22 Sep 2024 21:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=orbstack.dev; s=google; t=1727066219; x=1727671019; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/aCOx66mDLjCY2/CdXWC7lFsR07hWbPRUPFMOePtthQ=;
        b=GJGo4S7n6w3nlMkjk7pkDflw7eTiFaXtidlfUCYDnwfM9aP1D8yy4XIhcCgGRfbVKz
         m4wXtURGADlrZF9q4PUJMzFCkvE03TdDR/8RBoTliwfjc7x/3P0htTy7oZi7/JW5wjux
         8QegZy6hGlqeBMXMXf6c1JQPwFGyzdyRXdWNCyxAwlEqDQtlyvGPqOhDZDjrn/4G6Ed2
         rntYirmhmfdeJF3+AHMWfnaQLv4pPf2PE5v8zg/e9wDwlWFuiHZXxR2fA7IyvYuNpnHk
         Rho3Ns5K2Xssj00okBMojpMnWOmjGTY16akDNh4AtRxmS1NIO7BD/pao52OBi9WB9xnN
         25ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727066219; x=1727671019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/aCOx66mDLjCY2/CdXWC7lFsR07hWbPRUPFMOePtthQ=;
        b=akKcqJoxCV0111GoQzHXe4P+Nk/xAIPEvPZohgcHWTwjO/6tzLtBv4EGvLcmv4H2M/
         gZ48FNqZryxyq2PTrdfekWpTJ8a4zCcvoliPvAhXUPY8zh7Si9tO86uam6iwHDYz3q3A
         ej8HSaIfMRuzltk2cCb4IbLfv+JQepZHOEu4BEV5UrOh2eb9DOGgwShYPucfRg4y14ug
         StiQKqa+tf5DpcEeraUdzNEGOgsDgkW++gAVw/Nfimrvk8I+JlxeIB1NyDvgWHzoIIic
         xuDOnRbuehi3cI2GH1Lk6Q6RU8p65iYK/nUDx+wf49XpkIe4ysoU5sT5iL5FWyJeP+WJ
         hhmA==
X-Gm-Message-State: AOJu0Yy9kJfJ476pt/r3GmhAD3KrQpwnQNFeKHgdKuTEYbI1JLahrtkO
	CSQgF0X8HMgf89tERm91pNP3MPQ5wcBDiukfRODUMqHwXznGYmCkTisVdJ5gquiX0+Lq5UV4njP
	SZJvgjOwztI5FQBZmrDiEgzF7BY8HGqv93is66g==
X-Google-Smtp-Source: AGHT+IHgkLAciouLdEQfVy8twfYMwHgpHfgry6AOBlebXVrJElu0U/++9M/UxfLJS0SgVyklJDfafXysCUKAJzTvcjg=
X-Received: by 2002:a05:6a00:4fd2:b0:717:8a7c:dd82 with SMTP id
 d2e1a72fcca58-7198e2fcf77mr24072159b3a.9.1727066219259; Sun, 22 Sep 2024
 21:36:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240916073835.77470-1-danny@orbstack.dev> <CAEFvpLe92-nS+4zOv5a=UOMW2whBtsGZ98D_MHv+x_KujEaroQ@mail.gmail.com>
 <63307dbc-da27-42e6-86fb-ed446f04ede5@linux.alibaba.com> <2ada73ab-66c2-437c-bbc2-fd07cb42c265@linux.alibaba.com>
 <CAEFvpLcEKEhRVCDggHbmFeFJQqte_8BWAyc-40e4TZJPEQTUhA@mail.gmail.com>
In-Reply-To: <CAEFvpLcEKEhRVCDggHbmFeFJQqte_8BWAyc-40e4TZJPEQTUhA@mail.gmail.com>
Date: Sun, 22 Sep 2024 21:36:48 -0700
Message-ID: <CAEFvpLeBDf_BjwJJRc3Ecn7DMZNkFYsAri6=dy7ERQ2SFLmhFA@mail.gmail.com>
Subject: Re: [PATCH] erofs-utils: lib: fix compressed packed inodes
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
From: Danny Lin via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Danny Lin <danny@orbstack.dev>
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sun, Sep 22, 2024 at 9:30=E2=80=AFPM Danny Lin <danny@orbstack.dev> wrot=
e:
>
> On Sun, Sep 22, 2024 at 8:03=E2=80=AFPM Gao Xiang <hsiangkao@linux.alibab=
a.com> wrote:
> >
> > Hi Danny,
> >
> > On 2024/9/23 08:08, Gao Xiang wrote:
> > > Hi Danny,
> > >
> > > Thanks for the patch!
> > > Sorry I somewhat missed the previous email..
> > >
> > > On 2024/9/22 13:08, Danny Lin wrote:
> > >> Gentle bump =E2=80=94 let me know if anything needs to be changed!
> > >
> > > Does the following change resolve the issue too?
>
> Thanks for the suggestion. I tried your patch and it segfaults instead.

I think the segfault is because it returns ERR_PTR(0) instead of inode
on success. That should be an easy fix but we'd still be skipping
erofs_prepare_inode_buffer and erofs_write_tail_end.

>
> From a quick glance at the surrounding code, it doesn't seem correct
> because the calls to erofs_prepare_inode_buffer and
> erofs_write_tail_end are skipped if ret =3D=3D 0.
>
> > >
> > > Also I think it
> > > Fixes: 2fdbd28ad4a3 ("erofs-utils: lib: fix uncompressed packed inode=
")
>
> Ah, nice catch. Do you want me to resubmit or will you fix it when
> applying the patch?
>
> > >
> > > @@ -1927,7 +1926,7 @@ struct erofs_inode *erofs_mkfs_build_special_fr=
om_fd(struct erofs_sb_info *sbi,
> > >
> > >                  DBG_BUGON(!ictx);
> > >                  ret =3D erofs_write_compressed_file(ictx);
> > > -               if (ret && ret !=3D -ENOSPC)
> > > +               if (ret !=3D -ENOSPC)
> > >                           return ERR_PTR(ret);
> > >
> > >                  ret =3D lseek(fd, 0, SEEK_SET);
> >
> > Add some more words, I'm on releasing erofs-utils 1.8.2
> > this week.
> >
> > So if the diff above also fixes the issue, could you
> > submit a patch for this so I could merge in time?
> >
> > Thanks,
> > Gsao Xiang
> >
> > >
> > > Thanks,
> > > Gao Xiang
> > >
> > >>
> > >> Thanks,
> > >> Danny
> >
>
> Thanks,
> Danny

Thanks,
Danny
