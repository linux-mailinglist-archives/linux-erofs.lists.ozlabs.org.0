Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2029E1494
	for <lists+linux-erofs@lfdr.de>; Tue,  3 Dec 2024 08:47:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1733212040;
	bh=EJB0vnV/YRbnjMfg/QOdoUIMWoxQ+GAnPQ7GvyiWoOQ=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=jdrki57SdlAhL+jKT5sTOhUAr+CxfTqqk8mIyiCEEccpxtWq+AxO3iKOF61yACKmB
	 RnPOZm9EsR4EH0RuyX+BiakPopq7UkJ0D+2G+oiCgEfEbFzXQm1BEx9urAbHr1RxHx
	 BsQT/hVOeIMjnnwzx1tFYXLp+991/aDo2xNgqAOzahX3tdoMrqSrbGYOpwpmr2UmDI
	 8kIN9OhpEGCJtdlZ2z8UwlHkmm+ORHWJvU7DR69BtFzhJm9V1XLrcTaLQEPFr1ZGjO
	 EJccAtcgIEswCWDkbz3VxyAEVFHsKsXKiX5SS8qEmhVkA1mUEKpcK86tgWzBRSmER4
	 3jzSqkSS+HFNg==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y2Xmm1yxVz302c
	for <lists+linux-erofs@lfdr.de>; Tue,  3 Dec 2024 18:47:20 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::429"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1733212038;
	cv=none; b=OiIRDwsdZBYG73IPHU3oRGWkzXf/rBKTW1U3zgke54FA4OcFhSQkWHdmGEL0BobTfXqQinzLNmnJBkwRtG7/Vpd1p3bzRltfqGOQqdPzqjXNQEb0bD5YL2/3h/TrepWXtKov2LECGBsrKuQcpxwf0BdRzpW4zBAXhobelyrS7FJogYI/htLemhg+JIamJu1Qk5yCfdcJ1UMubBgcdFf3WV2bwy84cp+HQZpNMZUR9iZNDjKFFHU+nWtHcwoQvGt3+3CPsoz71e0ZLFOEnft50tPPVD3wj6udy27/0JqDsxeMx283lnimrMgsszWjNYGlTdvyqhv4pfsT/bHTL/dnyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1733212038; c=relaxed/relaxed;
	bh=EJB0vnV/YRbnjMfg/QOdoUIMWoxQ+GAnPQ7GvyiWoOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fWGx8XHpGMGLX6sFgHai8ROjIS7Ql2YvZqTJ05BFNLILxWqtQSb4dqGEwHTJwX32T+TMYYNAEuwMVyHjaXXYLTv/M3//3gj7KcCsBNrlVLED48Z3DfoNB6fZpiyXMOh8zp8GlSeZCMxxM3kzKWRoGdpKFPyfSn+89YZD48wMEFRCYIEwoq8A1NjE/T6njZ8bPjLkK2lxJAbT2Iyx+isxre/skmJmfqk6Z0MLwwTJbH2X+r78nQYfBCZwvBrUxDxKOOZAc86nD8b1tiQ9pZrkPeGkKXuCMHy7psmrDwljoMeJOb4lDsRqYA+MWQsFtlLwKBf7FhrN5C1N6qvgLxG36A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=0NBiaX/r; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::429; helo=mail-pf1-x429.google.com; envelope-from=jooyung@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=0NBiaX/r;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::429; helo=mail-pf1-x429.google.com; envelope-from=jooyung@google.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y2Xmj61b3z2yNP
	for <linux-erofs@lists.ozlabs.org>; Tue,  3 Dec 2024 18:47:17 +1100 (AEDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-724e6c53fe2so3874921b3a.3
        for <linux-erofs@lists.ozlabs.org>; Mon, 02 Dec 2024 23:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733212035; x=1733816835; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EJB0vnV/YRbnjMfg/QOdoUIMWoxQ+GAnPQ7GvyiWoOQ=;
        b=0NBiaX/reTpJ2akHA1abl5BBSfA2P5cqkc4Cdo9AGdUPo3pu4HjaKXl18Ch0+h31Ca
         uPE4FZjpMH39aF9NBxhKYGyTDH7Q2LQJbYMHAGQCiiaumWQo8X0azfFeoIcpd0+8lcc1
         iCvTSlQe6D5+yPSd6cOvHj9I67I97zDiuZB7pf1V6MNgQuzFH4XYzPQ0RWdWEyM1Kl3E
         t5TMK1t+qyuptcFk5iWLeOz8SjAs8biS3hxcq1XrKRs7/cGZR72gGp5NWaW4Wd266qjS
         GBj3hQ37g+p2l5UmEWBPixWN5wSq80ZkvCMXBoID91XD9nhUobo4MJ5LjDSwMYi7K40L
         xzlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733212035; x=1733816835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EJB0vnV/YRbnjMfg/QOdoUIMWoxQ+GAnPQ7GvyiWoOQ=;
        b=EJKbiRynCnmPLhayUB6U+epPHA2tMjIiMQPcZUhP/Xa1iHTkf4bV2WeB4fct9k0NSX
         ILktB1wHHW1iOIKHFhRERCdJyY5esA3ZzAvfZ9L9rAy9tvKM7kfawMl4fyWWhusf1JUA
         6qg3DfJRUrLOLHr7Duj56jAFCFTpaehAG/i+gdsd9vngTS+1JYETikBQ/X0AABuXmwZi
         JJnAzCy8thOx5g2u4ZpKWUREc3LygcA4kRnv+k6yeZafmGp/anjWh1zHF0RTqy8PW7/f
         IlHfYQxt/wAbLUQ5AiqpmXsAF0oHfGInu1g7GVl/pA4NPc95X/FXkzYLWi+sPSGMXXHp
         W51g==
X-Gm-Message-State: AOJu0Yx5Sso7Zs191+MOt1wlazXAt4GYuWUptO/AVKH8usLJakFjwXeQ
	kHXZKogCLaJq7ySkQq+z0njcoHYA8CTtBj/R/zCdbVwAMzrdcDr4fBF9VAubnk3SswkPn0lejVg
	wP20NngXlNLSzXuFkbkwIRMxtiKP408rX6yUg
X-Gm-Gg: ASbGncsp6Y6MdrOJEMcr9dJ4tyaS1J5HRtpLIzmbILrBlWQUjzi4sW8t2y/ayyb4Lgt
	3RlAxSZmDfsZA29ULfoVQ0Mb4N4weFWG/6sZFwsppoA+17sMO3kTgWOIMBLg=
X-Google-Smtp-Source: AGHT+IFAiEC0Sab8pTcNTI9n07GSMJxnzTXyCuv1L6zdRYgsOrE8ukinsxipAJWUMebvSsaqsKysg6JLt0o0wtL8OzE=
X-Received: by 2002:a05:6a00:13a7:b0:71e:4c2f:5bed with SMTP id
 d2e1a72fcca58-7257fcaa64emr2657608b3a.20.1733212032744; Mon, 02 Dec 2024
 23:47:12 -0800 (PST)
MIME-Version: 1.0
References: <20241203002720.3634151-1-jooyung@google.com> <a5b7aaf8-4b94-44dd-9bff-8e12080a8063@linux.alibaba.com>
 <CAO-8PLbD1hbRW24Xu+kJ6Ak9JZ+508sYgMa1oDB1PQ77YUptXg@mail.gmail.com>
 <b47f5ed4-dfe8-4ecd-b69e-4907f3a1e04d@linux.alibaba.com> <CAO-8PLYw-TM852eP1OBbixQUd+XGTReswfPXx41J3CMor-1YDg@mail.gmail.com>
 <c077161a-1a6a-4ab2-96ae-5b7f5fba802b@linux.alibaba.com>
In-Reply-To: <c077161a-1a6a-4ab2-96ae-5b7f5fba802b@linux.alibaba.com>
Date: Tue, 3 Dec 2024 16:47:00 +0900
Message-ID: <CAO-8PLbUJNVkVu8ATA4e65zqh9sgnUMntQRD+aboE44E9=iZng@mail.gmail.com>
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

Hi Gao,

Since the new patch is quite different from the last, I sent it as a
new one, instead of up-revving.


On Tue, Dec 3, 2024 at 3:58=E2=80=AFPM Gao Xiang <hsiangkao@linux.alibaba.c=
om> wrote:
>
>
>
> On 2024/12/3 14:37, Jooyung Han wrote:
> > (I forgot to reply all)
>
> Yeah, I received that.
>
> >
> > On Tue, Dec 3, 2024 at 11:36=E2=80=AFAM Gao Xiang <hsiangkao@linux.alib=
aba.com> wrote:
> >>
> >>
> >>
> >> On 2024/12/3 10:20, Jooyung Han wrote:
> >>> Hi Gao,
> >>>
> >>> I found that in the loop erofs_iget_from_srcpath() is called in
> >>> different order due to readdir and erofs_iget_from_srcpath() calls
> >>> erofs_new_inode() which fills i_ino[0] for newly created inode. I
> >>> think this i_ino[0] having different values caused the difference in
> >>> the output.
> >>
> >> Oh, okay, that makes sense, I think we'd better move
> >>
> >> inode->i_ino[0] =3D sbi->inos++;  /* inode serial number */
> >>
> >> to erofs_mkfs_dump_tree()  (since we'd better to leave
> >> i_ino[0] stable even without dumping from localdir later.)
> >> and even clean up a bit.
> >>
> >> If you don't have more time to clean up this, let's just
> >> commit a patch to fix this directly.
> >
> > Sounds good to me ;-)
> > To be honest, I don't know the stuff well enough for this cleanup.
>
> Ok, anyway if you could submit a patch that moves
> inode->i_ino[0] =3D sbi->inos++;
> from erofs_new_inode() to erofs_prepare_inode_buffer()
>
> I will apply directly.
>
> Also I'd like to update it as
> inode->i_ino[0] =3D ++sbi->inos;
>
> Since `i_ino =3D=3D 0` is invalid...
>
> Thanks,
> Gao Xiang
>
> >
> >>
> >> Thanks,
> >> Gao Xiang
> >
> > Thanks,
> > Jooyung
>
