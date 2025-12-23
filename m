Return-Path: <linux-erofs+bounces-1568-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BB3CD954C
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Dec 2025 13:42:06 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dbF565zF3z2xlP;
	Tue, 23 Dec 2025 23:42:02 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.208.51
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766493722;
	cv=none; b=A5vwbjSQ+E2vbNoXzdW+iiO43prH9nHP4/AM1WhN+/8jMb1a+Knh06f6bfVNERKPpD2uizJsgshEjiarfDJSSE2AIlnG5YoENWbeuThwMT4JFMALNy5ezVrGfhMpgdIHTDV5eM1IaVJ4hkCIswGzjn9P/1zCeYLsWqe6G/fwMEM78PK1pA7rr96rPgOR1Bhnsf71Z+o5q55hfG01dXArCwM8berCSE9v2mTAobgijUZA2cXlEi48nMhn3MfIEW3CzHuxSNbRqLaqaxqajOWPzh/QSLsD67VLIFSBNrszv+UxoNzvUQm6J6VY4WYnyy0j/BPZWb8UUO68szBxJVuxVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766493722; c=relaxed/relaxed;
	bh=V/94jwXt2/VaN6/conir65fhVEvy3Y293/LXtBDIEZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aY2vTlPptf1vZ9Iqk6Z/eNjHpAdIYgRwKmHAHTt+KzEiqAdSUMRAyXBRcP+ncZq9XvKvx1/FWjVrUMDQhdrHF0kDfsiLDa24k4W3xhaIGYnJLfVBV3YMJmKJ0Y3vXLUbccMM5L0r/VVMLM7yqWkL8YTgfCt3BN0P6JfgwaNGMPhV3AbPQ0MhjfRwXJQJixJyEyxkj35D4J2lxaxtRjHGox5hl+/d1kArRduTCAulmFSLstuy7dIbOVRseN8PPCEOdgeSr8U2KWWhh1mlh9FrZXw8yqzKJXMaVVUDrEnDpND7/WK2Ragh1xeHnCKvBV5/gXTOSgR+S18D3VXifTaipg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=WtbHjBRU; dkim-atps=neutral; spf=pass (client-ip=209.85.208.51; helo=mail-ed1-f51.google.com; envelope-from=amir73il@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=WtbHjBRU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.208.51; helo=mail-ed1-f51.google.com; envelope-from=amir73il@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dbF5523f6z2xQK
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 Dec 2025 23:42:00 +1100 (AEDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-64b4f730a02so7992958a12.0
        for <linux-erofs@lists.ozlabs.org>; Tue, 23 Dec 2025 04:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766493657; x=1767098457; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V/94jwXt2/VaN6/conir65fhVEvy3Y293/LXtBDIEZI=;
        b=WtbHjBRUwExg/H7k+34ZFP+40gsjU9pM9tyu9AAqurLLB1Hpnb5LGIDZsp4xrp4ASP
         zrHlYeCIxcVvXty4131+jgILFDvCMQ+aVeviOAyfCr3vPyVaV+jbb9bVrFs8P8XLFC5e
         /4epuupIz1bhrd6+Wp1EnQmLwanMuCwDZSFPTl4WTswBNgvRM7VESvUJ/43VpcpqEk9B
         AkeJDeah6OEDdzuGvJaUQQ52kabZGe1vyNhqXxfHLQcYhvd19ti9JMb72j4r82eZVo4c
         ynXgEVMcuiK+irekgck0fr5rjaZsApilKLt/XG8ghYDE2Gy3Vwh4/oPClj0VvlsWJEtt
         9iFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766493657; x=1767098457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V/94jwXt2/VaN6/conir65fhVEvy3Y293/LXtBDIEZI=;
        b=IyT4D6dj/GvY9CoBNh21R/r+H79L+Z8VqA06DEgF2NKftJSBDT58nqgYRITepIDukt
         RjT5bOkfujDFACMgLUQlhxc+hSYufP5qRPA4d36dINNBGuki6KuGU09OAV7p9/WBIfzm
         /fxRgLP7g2LNhCI+ffRXBlndBVuXB5V6pJ0TJH1Lc6ejFvLmtCWbRoDh4eJf6bcA8yZo
         gynbD7Yo/gT5a4bv8VINNHW9SY8GggCb8P1lWIxccCI387zqjotSpew7qUF/L+koSyKN
         86yQjnGojvuYtDFAoYujoqjBCdm2kEpFXCljRQAn71dnWGcyvBcwGcJvxMT3ke+4zNpg
         rZHg==
X-Forwarded-Encrypted: i=1; AJvYcCWqOKduxnfVls++JHxaEh6Z02GfumM1owco+MiriK4A5ub1HWbNEdzwBhDojE4YEW08vvt1yiSaKeusMQ==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxOxpYjx8BoEArf8ppiz9/nMi3qNjLpg0U1qx6XFkxCcBiuYvmd
	mhsRE+5MPfEYkSH3OVRwwNqfXZOt/NWUY5VY4rnB3gYiAfOAovR6tjKPmWzOHZBEPQX1SiNEyFt
	TPgNTdBOoNUsGitfmzcnRdHTeUdxH5zY=
X-Gm-Gg: AY/fxX7ybWbxPmhyDQm/cBVUnaNl+ZQNKU3vme7OxGe472kLcsk9iYS41D6lKCNnUU7
	OtA/G9GIVzDbAaMUmwWcBClW9BFaAjmKFVMp4YlIkVjXRE/SO1sS2wRmrCGZucndt9Mu+VfjM2u
	ahzzYiyXnOsGlEcU2VmlsMgKxS5fxiS0paTPBX5WwQJYxbIa3l1+RX2QBoa/gQ5xaqF5jRbQR6/
	Vw9TdRqWhd8UJxELCj6xoP8vRnEuRkwV5R+RrizcJKpVbudhZQgTsiByBerUn83zBLdso+42IbJ
	EvYYw3udq3SRD0YrYPvRMmruagXyOQ==
X-Google-Smtp-Source: AGHT+IEhHo/hN4J9FTc1P4sGEYhA78bE8EllUl442/57HCgAcjltBYKaHTxZkZCcOdqcGslEVHdOWBuZgmToXvnbfII=
X-Received: by 2002:a05:6402:3591:b0:64d:ab6b:17e0 with SMTP id
 4fb4d7f45d1cf-64dab6b199dmr2135230a12.27.1766493656805; Tue, 23 Dec 2025
 04:40:56 -0800 (PST)
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
References: <20251223015618.485626-1-lihongbo22@huawei.com>
 <20251223015618.485626-4-lihongbo22@huawei.com> <e143fe52-d704-46d3-9389-21645bb19059@linux.alibaba.com>
In-Reply-To: <e143fe52-d704-46d3-9389-21645bb19059@linux.alibaba.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 23 Dec 2025 13:40:48 +0100
X-Gm-Features: AQt7F2qBtYIkh7GKPTQm5R_Zd5bGQq3KAbZ7Z9YPLbkt7T3I1moSNvGdJ6tD4Nk
Message-ID: <CAOQ4uxjH3JmNd8yiBwz11+j_t=PArPGeGUHCukiNpw9L1BUp6A@mail.gmail.com>
Subject: Re: [PATCH v10 03/10] fs: Export alloc_empty_backing_file
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Hongbo Li <lihongbo22@huawei.com>, linux-fsdevel@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	Chao Yu <chao@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	"Darrick J. Wong" <djwong@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Tue, Dec 23, 2025 at 10:31=E2=80=AFAM Gao Xiang <hsiangkao@linux.alibaba=
.com> wrote:
>
>
>
> On 2025/12/23 09:56, Hongbo Li wrote:
> > There is no need to open nonexistent real files if backing files
> > couldn't be backed by real files (e.g., EROFS page cache sharing
> > doesn't need typical real files to open again).
> >
> > Therefore, we export the alloc_empty_backing_file() helper, allowing
> > filesystems to dynamically set the backing file without real file
> > open. This is particularly useful for obtaining the correct @path
> > and @inode when calling file_user_path() and file_user_inode().
> >
> > Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
>
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>
> (I hope Amir could ack this particular patch too..)

As long as Chritian is ok with this, I don't mind.

Acked-by: Amir Goldstein <amir73il@gmail.com>

Thanks,
Amir.

