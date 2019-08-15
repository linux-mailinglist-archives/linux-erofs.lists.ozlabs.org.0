Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27FE28F05F
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Aug 2019 18:21:08 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 468WsY0xSszDr7h
	for <lists+linux-erofs@lfdr.de>; Fri, 16 Aug 2019 02:21:05 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linuxfoundation.org
 (client-ip=2a00:1450:4864:20::243; helo=mail-lj1-x243.google.com;
 envelope-from=torvalds@linuxfoundation.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org
 header.b="GiMGu61r"; dkim-atps=neutral
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com
 [IPv6:2a00:1450:4864:20::243])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 468WsR475LzDr2K
 for <linux-erofs@lists.ozlabs.org>; Fri, 16 Aug 2019 02:20:58 +1000 (AEST)
Received: by mail-lj1-x243.google.com with SMTP id e27so2718878ljb.7
 for <linux-erofs@lists.ozlabs.org>; Thu, 15 Aug 2019 09:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FuOQKA7vgPA06is52x9xKpXiDGgbCZoxJgLKNkyGfUs=;
 b=GiMGu61r0de7kE+jxFqk2ISTMZec3MCIu0HBqAiSXGeSP8AeU/RC1ZhX/syTNiFag1
 vef2zaQMkRgI5yQRnEcUQA2HqnQz4O2DAMgPqxYorQxLdg6N07Qt35SI/EEKkX7h+ocx
 AGxQCZHY70aVP3rFrb29kL6nHWXMwFLTwSK+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FuOQKA7vgPA06is52x9xKpXiDGgbCZoxJgLKNkyGfUs=;
 b=BI0p/JuIb8bindRETsWquv5q6zbHfajNKUkk7uyBbv53NfP7DaqupP+rfPUGPcZGvo
 YLC1rra7yA+kvaEeixhq1i4CIsb8OxxyhdjwfU+mqjwETu4fJwweVDRxlnMc8O0A9czo
 5+CqyKVZvsQnv448uqoQvfAfMi8euSCDuEcLbJleZFzsNHR8uF98H9iW9EKnwIOLNzjS
 w+b2EXSX2uEJVme3nj2NEH3QG+BozbZGB6IaF5depVlY5ysGAGThxKVEKF7hqt2Txxlb
 I3sOt8dv9JMlRjV89NTwyRUU/9lodg7G828bYoNEMi16oN3a2195jC1vuhY2ojFR8M4U
 D7Pg==
X-Gm-Message-State: APjAAAVPX5TygTxlSZiexXhLObuCKZVCrEZccCwxtJM6nB3lvnuZvoye
 BZ8YSvFdJ9Err4RnicBPqtEP4yY1FY4=
X-Google-Smtp-Source: APXvYqz06gtE9LaLvjkMObLxMvR1BIxTpnj7RqMV/V8J/ROBv6hjWhpoA8rv3Dwz2w1GTA3K7KRAAg==
X-Received: by 2002:a2e:82c7:: with SMTP id n7mr2000927ljh.131.1565886054095; 
 Thu, 15 Aug 2019 09:20:54 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com.
 [209.85.208.176])
 by smtp.gmail.com with ESMTPSA id j22sm550590ljg.17.2019.08.15.09.20.53
 for <linux-erofs@lists.ozlabs.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Aug 2019 09:20:53 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id l14so2747367lje.2
 for <linux-erofs@lists.ozlabs.org>; Thu, 15 Aug 2019 09:20:53 -0700 (PDT)
X-Received: by 2002:a2e:7018:: with SMTP id l24mr3046966ljc.165.1565885615360; 
 Thu, 15 Aug 2019 09:13:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190815044155.88483-1-gaoxiang25@huawei.com>
 <20190815044155.88483-8-gaoxiang25@huawei.com>
In-Reply-To: <20190815044155.88483-8-gaoxiang25@huawei.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 15 Aug 2019 09:13:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiUs+b=iVKM3mVooXgVk7cmmC67KTmnAuL0cd_cMMVAKw@mail.gmail.com>
Message-ID: <CAHk-=wiUs+b=iVKM3mVooXgVk7cmmC67KTmnAuL0cd_cMMVAKw@mail.gmail.com>
Subject: Re: [PATCH v8 07/24] erofs: add directory operations
To: Gao Xiang <gaoxiang25@huawei.com>
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
Cc: Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>,
 David Sterba <dsterba@suse.cz>, Miao Xie <miaoxie@huawei.com>,
 devel@driverdev.osuosl.org, Stephen Rothwell <sfr@canb.auug.org.au>,
 "Darrick J . Wong" <darrick.wong@oracle.com>,
 Richard Weinberger <richard@nod.at>, Christoph Hellwig <hch@infradead.org>,
 Amir Goldstein <amir73il@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@denx.de>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Aug 14, 2019 at 9:42 PM Gao Xiang <gaoxiang25@huawei.com> wrote:
>
> +
> +static const unsigned char erofs_filetype_table[EROFS_FT_MAX] = {
> +       [EROFS_FT_UNKNOWN]      = DT_UNKNOWN,
> +       [EROFS_FT_REG_FILE]     = DT_REG,
> +       [EROFS_FT_DIR]          = DT_DIR,
> +       [EROFS_FT_CHRDEV]       = DT_CHR,
> +       [EROFS_FT_BLKDEV]       = DT_BLK,
> +       [EROFS_FT_FIFO]         = DT_FIFO,
> +       [EROFS_FT_SOCK]         = DT_SOCK,
> +       [EROFS_FT_SYMLINK]      = DT_LNK,
> +};

Hmm.

The EROFS_FT_XYZ values seem to match the normal FT_XYZ values, and
we've lately tried to just have filesystems use the standard ones
instead of having a (pointless) duplicate conversion between the two.

And then you can use the common "fs_ftype_to_dtype()" to convert from
FT_XYZ to DT_XYZ.

Maybe I'm missing something, and the EROFS_FT_x list actually differs
from the normal FT_x list some way, but it would be good to not
introduce another case of this in normal filesystems, just as we've
been getting rid of them.

See for example commit e10892189428 ("ext2: use common file type conversion").

               Linus
