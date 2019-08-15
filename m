Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5B88F069
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Aug 2019 18:25:07 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 468Wy83BRMzDr7h
	for <lists+linux-erofs@lfdr.de>; Fri, 16 Aug 2019 02:25:04 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linuxfoundation.org
 (client-ip=2a00:1450:4864:20::242; helo=mail-lj1-x242.google.com;
 envelope-from=torvalds@linuxfoundation.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org
 header.b="GdUTEFZx"; dkim-atps=neutral
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com
 [IPv6:2a00:1450:4864:20::242])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 468Wy42ZdBzDr58
 for <linux-erofs@lists.ozlabs.org>; Fri, 16 Aug 2019 02:24:57 +1000 (AEST)
Received: by mail-lj1-x242.google.com with SMTP id t3so2702461ljj.12
 for <linux-erofs@lists.ozlabs.org>; Thu, 15 Aug 2019 09:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9Io8f1bPaeNDioMtOu6b9FaHz1PaQCP05A6nz5CudSE=;
 b=GdUTEFZxtX4Lqzwngdfr2kBTyvwT41GJPNn6kb81iJMXzazObo52enBgWkwrOOq3lr
 fcNdZi8U6UPgNqNDEBWhKZKeMiP71ad8QufdLOLqaXmVo1Qm1ZJcKLGCfWYtcR0rwDEt
 373s5sBtHdFaBBHWllHqZ5/T8eYXJ/Nx4+edw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9Io8f1bPaeNDioMtOu6b9FaHz1PaQCP05A6nz5CudSE=;
 b=AGHiyk0IS3w/cmhPE0PAn5qYBU7EOTsTTCIoA/MFESLI50UD9ZTenngnflOqlQ649J
 c8or1wFlLptXYCNKUfxWiq594oK4jRbJKf1dvBj4nqwHAgZxVc9Fyrf+bzrl+VBKo8tz
 U36C7rvP2A5LS0fZ2xcW6hrRaVNhB6gOfzcHjUSO85iBnNu7cfPO4U+P3e88PwYbfp/3
 9iPBzyh483bjlI8RV8YPyN0px+K1/0FhL8OoUYNaIBvqjG1mNsGKznIxig7VmZaIqOdi
 DC0T2Kq0OqH/vWhl3cldzUS7Dz4T4gBOmmqAsqTY32ajGYWn1/qwf8zHCVEL8EgOAGQY
 O1+Q==
X-Gm-Message-State: APjAAAVcQ2+P2yU/L4znM7f9/D65NcVwmF2IoDzElme4XkzOLWVeXNDk
 GcUdOufUH3KaOSLyYQ56flVU82JvaDk=
X-Google-Smtp-Source: APXvYqzsxzOls8toQ12++qmMYR6ROI0W63zmW+pTo3fI4kV2WU8ibIRF1YnLvuX9HacXlJcHwl0X6A==
X-Received: by 2002:a2e:12c8:: with SMTP id 69mr3028272ljs.189.1565886294811; 
 Thu, 15 Aug 2019 09:24:54 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com.
 [209.85.208.172])
 by smtp.gmail.com with ESMTPSA id m4sm555400ljj.78.2019.08.15.09.24.54
 for <linux-erofs@lists.ozlabs.org>
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 15 Aug 2019 09:24:54 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id t14so2751590lji.4
 for <linux-erofs@lists.ozlabs.org>; Thu, 15 Aug 2019 09:24:54 -0700 (PDT)
X-Received: by 2002:a2e:9192:: with SMTP id f18mr3104005ljg.52.1565885908392; 
 Thu, 15 Aug 2019 09:18:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190815044155.88483-1-gaoxiang25@huawei.com>
 <20190815090603.GD4938@kroah.com>
In-Reply-To: <20190815090603.GD4938@kroah.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 15 Aug 2019 09:18:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjKz7JLd=mj0w2LUiWC2_VOeNWhTTrw1j-i-KyEHH5g5w@mail.gmail.com>
Message-ID: <CAHk-=wjKz7JLd=mj0w2LUiWC2_VOeNWhTTrw1j-i-KyEHH5g5w@mail.gmail.com>
Subject: Re: [PATCH v8 00/24] erofs: promote erofs from staging v8
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
 Dave Chinner <david@fromorbit.com>, David Sterba <dsterba@suse.cz>,
 Miao Xie <miaoxie@huawei.com>, devel@driverdev.osuosl.org,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 "Darrick J . Wong" <darrick.wong@oracle.com>,
 Richard Weinberger <richard@nod.at>, Christoph Hellwig <hch@infradead.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Theodore Ts'o <tytso@mit.edu>, Pavel Machek <pavel@denx.de>,
 LKML <linux-kernel@vger.kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Aug 15, 2019 at 2:06 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> I know everyone is busy, but given the length this has been in staging,
> and the constant good progress toward cleaning it all up that has been
> happening, I want to get this moved out of staging soon.

Since it doesn't touch anything outside of its own filesystem, I have
no real objections. We've never had huge problems with odd
filesystems.

I read through the patches to look for syntactic stuff (ie very much
*not* looking at actual code working or not), and had only one
comment. It's not critical, but it would be nice to do as part of (or
before) the "get it out of staging".

                 Linus
