Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE1F82CFED
	for <lists+linux-erofs@lfdr.de>; Sun, 14 Jan 2024 08:18:51 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=gAdnXeJz;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TCRTM1n53z3bl6
	for <lists+linux-erofs@lfdr.de>; Sun, 14 Jan 2024 18:18:47 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=gAdnXeJz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::134; helo=mail-il1-x134.google.com; envelope-from=zbestahu@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TCRTC50pxz2ys9
	for <linux-erofs@lists.ozlabs.org>; Sun, 14 Jan 2024 18:18:37 +1100 (AEDT)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-3606ebda57cso37775305ab.2
        for <linux-erofs@lists.ozlabs.org>; Sat, 13 Jan 2024 23:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705216713; x=1705821513; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EfOY4hqiuCt9vvQdw+q0DGwlOUMbwjspM6TDeMSz84Q=;
        b=gAdnXeJzibAP4Mvy70DjRkM5V9GBtRfqygjCEs4HbKbs2T1N0iTC/BTKL0GCCjhoG4
         Gc3clDdi6PINWAzpWkKEKQKIhUXf3qq7YAzegaS8fatBzsj0wEz2QcgMOJn2fguZyIK9
         y15xdUM0zTbOgfEm8m5MA5Az6aV4eJTPqwcx3qxKtBPPsFFRRL9bQjvc9j/iaTsH0BCb
         FW208DHYqI5xEXAKKKYsQDoAqNDSGekiLgYIw9uJjGeHssclyt18scRAf9yaO4sUCDuJ
         PuqxUOGwjGZj5GcQZZBkPMZUd5OHFLSXP5dgjff9sEjvs4SjUGe8tZK9L8JQNuNGAQFN
         cp6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705216713; x=1705821513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EfOY4hqiuCt9vvQdw+q0DGwlOUMbwjspM6TDeMSz84Q=;
        b=fmx1QHJRZN/eDlLWjvc6REUlOIPsl/PSGGCdnKlfuFsdrQllAsqwVhgTZC1l3aThnI
         +A/XazAPxEThMSgO19Mo7MnfeOUUnOVyCw5RB/YzWjEEoGeNdqdaqCZYHZeoERf4S1aR
         PO0EeTH3P3UpgkOpWmRq02YVcEiVs7fT2ALvTLyIgaLKDZp8/NzIV0QMkfuWyWB6Ki/u
         r/JD2v9DlYQJDJVj2U3dqi75yM9y5BqsKRLiguCDpd7xNEBl1T9oIfW6/ex4eMa3+ThC
         jRPiMSHin3V/bmhDSXRdwOYzPmKmwjEP8uOZfwJCoxQyYxoNKygA9KfZyLCYE5Xe1Jh/
         NKwg==
X-Gm-Message-State: AOJu0YwT+SDhwR1suXuPy7ZiQ33EWHrD/82jfD4B+csH5q60GDaABqHa
	f/s1tlm2ZH5FWLexVF1DLYY=
X-Google-Smtp-Source: AGHT+IH89Ue0mEG16bVI0Uxlq9NOSdM42keewy/S73kshmAMlNO6CA0Ezeff/2053Y11e/Vuk6J0nw==
X-Received: by 2002:a6b:f90a:0:b0:7be:dc94:766a with SMTP id j10-20020a6bf90a000000b007bedc94766amr5059898iog.0.1705216713583;
        Sat, 13 Jan 2024 23:18:33 -0800 (PST)
Received: from localhost ([156.236.96.164])
        by smtp.gmail.com with ESMTPSA id mf3-20020a170902fc8300b001d075e847d5sm5690600plb.44.2024.01.13.23.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jan 2024 23:18:33 -0800 (PST)
Date: Sun, 14 Jan 2024 15:18:27 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH v3] erofs: fix inconsistent per-file compression format
Message-ID: <20240114151827.000069d6.zbestahu@gmail.com>
In-Reply-To: <20240113150602.1471050-1-hsiangkao@linux.alibaba.com>
References: <20231227050633.1507448-1-hsiangkao@linux.alibaba.com>
	<20240113150602.1471050-1-hsiangkao@linux.alibaba.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-w64-mingw32)
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
Cc: bugreport@ubisectech.com, Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sat, 13 Jan 2024 23:06:02 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> EROFS can select compression algorithms on a per-file basis, and each
> per-file compression algorithm needs to be marked in the on-disk
> superblock for initialization.
> 
> However, syzkaller can generate inconsistent crafted images that use
> an unsupported algorithmtype for specific inodes, e.g. use MicroLZMA
> algorithmtype even it's not set in `sbi->available_compr_algs`.  This
> can lead to an unexpected "BUG: kernel NULL pointer dereference" if
> the corresponding decompressor isn't built-in.
> 
> Fix this by checking against `sbi->available_compr_algs` for each
> m_algorithmformat request.  Incorrect !erofs_sb_has_compr_cfgs preset
> bitmap is now fixed together since it was harmless previously.
> 
> Reported-by: <bugreport@ubisectech.com>
> Fixes: 8f89926290c4 ("erofs: get compression algorithms directly on mapping")
> Fixes: 622ceaddb764 ("erofs: lzma compression support")
> Reviewed-by: Yue Hu <huyue2@coolpad.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

LGTM.

Reviewed-by: Yue Hu <huyue2@coolpad.com>
