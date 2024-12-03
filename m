Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D519E136A
	for <lists+linux-erofs@lfdr.de>; Tue,  3 Dec 2024 07:37:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1733207874;
	bh=qFtXJUdYDGeeO8jsDmIhH09SSqSWSx1FKnx9p3XZb0A=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Lt9gLkyR6NOiyTXgIhZOSiBiFYwW7hiym26HpLfwCvSPZrxz57nu+rVrl3vteDj5O
	 DIBmPx+p5KaG4yNcejfVr0Gk10pZfa1ppjHXdgtCzW+cZtzuzdPT96CVjSVZpt+P5o
	 UgMGiv/gnSZD4j8QD/XY32YHycUpDeIXJgiLis7mVkCPH3C9kVvkSAGrmXD8Rnl6V8
	 3EFbu3HQK781igPzqzIubdVZ7zy0fXYFG1wdrS3/4sGybziC8m+Lyr7T/4FwdyxMD1
	 yNK6FpDjVeLml9ApzyHADlrGmSvsf51ZK9Q2CsobKNLn8spudOVXsWvmQQ/f1XFkQC
	 L5v34oVPtv90A==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y2WDf1csPz301D
	for <lists+linux-erofs@lfdr.de>; Tue,  3 Dec 2024 17:37:54 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1733207873;
	cv=none; b=WqpvE69wfoWxUYqHyOUfibg7xCgy+7WR0+b3ojfB4myjTqxhzsXV8fZTy5qZRHZ6zJtDK6kLbhuKjnL20Ti5cStTdNG9gr1rQQKtV96yONpJbv8r+L2AyueKjbf4UMXUu7usoEmWP6OqlUQJVMWihWGssQnFsP+d8rFQ6v4X2wvQJRgjmA1WvhQ70YU5LNJGiOhzGBsZFqlx/KiURqLzrW//Hh+bdy7GA15N7xs7jW8tIR0wzPtY/OeWE3D+84eXBwCaJkPRd/thI51rqJBeBf8ykWqEqJ6LkRh38IS5LkB3Q7m2PXZtEU4TzPzcarZ2RcXGJ0p8ntY0ac8UMGm5Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1733207873; c=relaxed/relaxed;
	bh=qFtXJUdYDGeeO8jsDmIhH09SSqSWSx1FKnx9p3XZb0A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sj2nf5GgjB3/LtMPcATVWIbneRERMuE6QXjiSVLXmp2/58ZYU2Wq5O0l9jp1Fy/707F0y+BIx+5N+9pv93WmK7Vh0MfioboNM3nOlAb/DrZ8/fU4ib+LK327iKUnhhhJdtGQbUMtyzoZJaEiHaB/RkUPC7XdwC7AZevfg174jfyG5KTuAPkyHxTHWVMnCmQGqx0Rzsco2v68q+3nl+5BKoL7/UzuAmORDcq0rtS7KGpew9LjF/LExF6CJDqBZuMzVK9O67NpqMeg7/ZaG+yI73smtfXRdbWtApE7CNK7ve1Yki6qJCECgUsh96oijUlUFvW/1Z79DPBugU7GvVOc6A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=Sq1kbOZE; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52c; helo=mail-pg1-x52c.google.com; envelope-from=jooyung@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=Sq1kbOZE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::52c; helo=mail-pg1-x52c.google.com; envelope-from=jooyung@google.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y2WDY0GVYz2xCj
	for <linux-erofs@lists.ozlabs.org>; Tue,  3 Dec 2024 17:37:47 +1100 (AEDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-7fcc8533607so1517749a12.0
        for <linux-erofs@lists.ozlabs.org>; Mon, 02 Dec 2024 22:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733207863; x=1733812663; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qFtXJUdYDGeeO8jsDmIhH09SSqSWSx1FKnx9p3XZb0A=;
        b=Sq1kbOZEO8C8wPQUy5qbllXsIZhySYkAXFe4teFcz4n7VvBL6PB2mBN+emh8vAlC7t
         qRfUAH0l4pl0KdapiOd2LEVxmEVrJRTEPyemR49oJVzgqHwjoOw0X73nFTfrayD9s0Xt
         YZuq2RL62F9lbfwaU8Kp0HTOsvtYW3xZLXIGJSUv+MzF9S3Fl4vwUR26nIkMh1LeM+NO
         VwhIeBck7UTl3st/G3QHMrY3LtYEO64mpUF71D2nyaSFfOnXYnJ0b8t3wf/cbAE0/Ang
         2bPoptsB6v/ArArBm6CYdvrdi71j/DusRdpPEYkDvLBGGtqUPb8VQjE/uHP3zGkeRE5b
         u9Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733207863; x=1733812663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qFtXJUdYDGeeO8jsDmIhH09SSqSWSx1FKnx9p3XZb0A=;
        b=IcKOcGBGaZCSsld0ACQivaMjvLCpZ+9vZOMNGxLGzVcOLOhfL03TzP0mZGoxLBK6Ij
         kpLL1Ck4e92Bvr+2Z02AWdAeoj/5AjDgxxop5WmFxP3gLF2U8NqopMWwIfM8NQFPd133
         QSg5JRcwRG3eE36/7Va7eK+1TcocCD/CamUp+wVssZH9xjvzSuOGXe6ZdcIhshbncJPY
         Vvb3tVn0K/GiR9uwDJiAfBqFMNZ5GGtCl8qCYSWU97iGltbmdI4cChGAElQa5VG32YXJ
         LdPRZ/MXQZLU32yFMfb837nD5VE3oHFwdpeie75G/igS7lx0PLqd29PxV96fB3oJ3goq
         TG/w==
X-Gm-Message-State: AOJu0Ywv9aAz9nyKPdjI6ixMvwvFhKodcu6tPKrlLo8iWhafeSvmYgxe
	QkSJf83Zsprp6R5ql3WsewWopN0ZiXQML+ld2vFwQ2Ysu+w2ml5aXoVknrJy9p7F5ko6dVWhC22
	wIVweJfQ+NNje7W9q+2B5qlSKhV2zrs67MMLI
X-Gm-Gg: ASbGnctShwaR5SO2u8vf6hrr+sOc4PU5cYkZ/Ghuxj78Acq2CqbuxiC1z9hd9e9y20C
	Ksv6NUG9ICQvpiKVZKLPhzOQ76JuhSmyOeoainIAF+O1Yf2JGt9KzVNnwaYs=
X-Google-Smtp-Source: AGHT+IH5R1tMYGAJ1H1SqxSVB9u3Y2C5TfAS7dQXNPI9IMO5xY513C4Z9ms5EGLkOAak2DVvjRRMiRjJ2bv2Hm+LOeM=
X-Received: by 2002:a05:6a20:914c:b0:1dc:790e:3bd0 with SMTP id
 adf61e73a8af0-1e1653bb804mr1910634637.15.1733207862949; Mon, 02 Dec 2024
 22:37:42 -0800 (PST)
MIME-Version: 1.0
References: <20241203002720.3634151-1-jooyung@google.com> <a5b7aaf8-4b94-44dd-9bff-8e12080a8063@linux.alibaba.com>
 <CAO-8PLbD1hbRW24Xu+kJ6Ak9JZ+508sYgMa1oDB1PQ77YUptXg@mail.gmail.com> <b47f5ed4-dfe8-4ecd-b69e-4907f3a1e04d@linux.alibaba.com>
In-Reply-To: <b47f5ed4-dfe8-4ecd-b69e-4907f3a1e04d@linux.alibaba.com>
Date: Tue, 3 Dec 2024 15:37:31 +0900
Message-ID: <CAO-8PLYw-TM852eP1OBbixQUd+XGTReswfPXx41J3CMor-1YDg@mail.gmail.com>
Subject: Re: [PATCH v2] erofs-utils: mkfs: use scandir for stable output
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
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
From: Jooyung Han via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Jooyung Han <jooyung@google.com>
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

(I forgot to reply all)

On Tue, Dec 3, 2024 at 11:36=E2=80=AFAM Gao Xiang <hsiangkao@linux.alibaba.=
com> wrote:
>
>
>
> On 2024/12/3 10:20, Jooyung Han wrote:
> > Hi Gao,
> >
> > I found that in the loop erofs_iget_from_srcpath() is called in
> > different order due to readdir and erofs_iget_from_srcpath() calls
> > erofs_new_inode() which fills i_ino[0] for newly created inode. I
> > think this i_ino[0] having different values caused the difference in
> > the output.
>
> Oh, okay, that makes sense, I think we'd better move
>
> inode->i_ino[0] =3D sbi->inos++;  /* inode serial number */
>
> to erofs_mkfs_dump_tree()  (since we'd better to leave
> i_ino[0] stable even without dumping from localdir later.)
> and even clean up a bit.
>
> If you don't have more time to clean up this, let's just
> commit a patch to fix this directly.

Sounds good to me ;-)
To be honest, I don't know the stuff well enough for this cleanup.

>
> Thanks,
> Gao Xiang

Thanks,
Jooyung
