Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85117EA9CC
	for <lists+linux-erofs@lfdr.de>; Thu, 31 Oct 2019 04:59:37 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 473WmQ4TD4zF5WS
	for <lists+linux-erofs@lfdr.de>; Thu, 31 Oct 2019 14:59:34 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=vt.edu
 (client-ip=2607:b400:92:8400:0:33:fb76:806e; helo=omr2.cc.vt.edu;
 envelope-from=valdis@vt.edu; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=vt.edu
X-Greylist: delayed 2532 seconds by postgrey-1.36 at bilbo;
 Thu, 31 Oct 2019 14:59:27 AEDT
Received: from omr2.cc.vt.edu (omr2.cc.ipv6.vt.edu
 [IPv6:2607:b400:92:8400:0:33:fb76:806e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 473WmH16cYzF5WK
 for <linux-erofs@lists.ozlabs.org>; Thu, 31 Oct 2019 14:59:25 +1100 (AEDT)
Received: from mr4.cc.vt.edu (mr4.cc.ipv6.vt.edu
 [IPv6:2607:b400:92:8300:0:7b:e2b1:6a29])
 by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x9V3H7e9026544
 for <linux-erofs@lists.ozlabs.org>; Wed, 30 Oct 2019 23:17:07 -0400
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mr4.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x9V3H2uX020873
 for <linux-erofs@lists.ozlabs.org>; Wed, 30 Oct 2019 23:17:07 -0400
Received: by mail-qt1-f197.google.com with SMTP id k9so4801450qtg.2
 for <linux-erofs@lists.ozlabs.org>; Wed, 30 Oct 2019 20:17:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
 :mime-version:content-transfer-encoding:date:message-id;
 bh=UjwFl/5kyrrhReHkQKPm1SCGM6jwLyZlLmQqSsl7mww=;
 b=Z/Zkqyn+QD/EwDVI/tU+KOLVsLRsAH1L79YjICPOPGOX7ng5d+r0pM3MHA8yysCVzE
 zbbig8Xq+17VX1KJ8FxH0Hs271bH98s7B7Lccni2gW8jU3l/nyPmSTwmWRBIBx+9LdWY
 FjxqpsbCAhC+gjXBMVosYA2zdmShPDRUN+a91up3BWb/6dkrP4No2QKjK5lQHZNnwpy7
 DWSQN+s6f39QVheLFzOu5gRqq1kboiyEs3biA4znQmnK1WtKIGi0W7lR+eyIXucnq/u4
 Qk7R8bXDOmYaAWpBi2BdrcZ1GKyyF0hV8wOs2Ok4vzi/ieGWS7ajnAeZ1wgo/Up/occe
 YGNw==
X-Gm-Message-State: APjAAAXwIzffhZEzL3TlfT5NK3yGZgMmSjQZAH9spzdG246SOXs9wErV
 dD3yQUvTWu4uInSRbcpOKjyGHap29WUU8Y5I0qV8lVHiDoyrGxCmZIC6Yyi1+xCtM2QR03bAtlD
 G3ToJGKJhkxsDLR9a8XG7rsOmxTVkGyFVy/Y=
X-Received: by 2002:a37:bf02:: with SMTP id p2mr3402561qkf.42.1572491822465;
 Wed, 30 Oct 2019 20:17:02 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyBRYNvJgULHc6/HirPX/JJlwuT5MkpOcps7z7Wgn9SXa/v+KbkipNm/PXten1R1WQp8wUltQ==
X-Received: by 2002:a37:bf02:: with SMTP id p2mr3402548qkf.42.1572491822161;
 Wed, 30 Oct 2019 20:17:02 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:c9e1::359])
 by smtp.gmail.com with ESMTPSA id t132sm1220848qke.51.2019.10.30.20.16.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2019 20:17:00 -0700 (PDT)
From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks"
 <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [RFC] errno.h: Provide EFSCORRUPTED for everybody
In-Reply-To: <20191031030449.GV15222@magnolia>
References: <20191031010736.113783-1-Valdis.Kletnieks@vt.edu>
 <20191031030449.GV15222@magnolia>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1572491818_4623P";
 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 30 Oct 2019 23:16:59 -0400
Message-ID: <120748.1572491819@turing-police>
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
Cc: devel@driverdev.osuosl.org, linux-arch@vger.kernel.org,
 Theodore Ts'o <tytso@mit.edu>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.com>,
 linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 Gao Xiang <xiang@kernel.org>, linux-ext4@vger.kernel.org,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

--==_Exmh_1572491818_4623P
Content-Type: text/plain; charset=us-ascii

On Wed, 30 Oct 2019 20:04:49 -0700, "Darrick J. Wong" said:

> I would add (d) can we do the same to EFSBADCRC, seeing as f2fs,
> ext4, xfs, and jbd2 all define it the same way?

If this one flies, that's a good candidate for a second patch....

--==_Exmh_1572491818_4623P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXbpSKgdmEQWDXROgAQJYmA/+PTG0+FXdOKpnGaoDDFNKM1tIitWpnoi9
02VrxRtAXg+D3lFix+ADGPwdAI9qKi2oMzxnOdTY81JCchjmp2rN4y1iABx5+Vy1
8eS3gGF2xihheSUp/wLsq4tQx7mY4DkcWIRsuRSmj3PPEZotxvNMkLFox/+xHCSk
RXdXLU/kO9LZjdFdlxQ26/X9pwhTn6USWRD73f5lVzQ49IChhB+Ww3UJj2RUm4vK
hkzocyTyA+tGSKEqh3b508buuxiUjWjYFFr8KWUzkd5Of/zgoddbTGXG117ILwDO
V+kQgt2ZAIESvyDXpBDnkPDclJPgv9aQgkAKdSb94BoMqiry75amO2JuxCNaZcnr
usLK+H7vWv++FXsA7BPhPAM0xuQRBbWA0sByEcKuHZEP5Z3LKjzIG8UqcbzJsRh4
ZbmqnW34sqYegs16RUj6Uv3CpRQmNwgit0m4lovTVfHTv+5ZK65e2O615RJajHpE
KKmSLCZCbLPN9TSAGm+p3m0aIoDH4+b5rp6KQDjfXJR3I8o0um8cLA6ejWmzhdVc
NMJSDVYw/px/5FU35XocFQERd9DCHYmTtNg2PhPffAKY2Og0YTzyxqxu2aT1ao5S
xLKZ1MHhLpDGdYhkJDvDHZPypg5kjtJN47yNF7naKgY7Xnt9i4s++1xoSSUVsj1a
8rFfLA7uEbY=
=RvfI
-----END PGP SIGNATURE-----

--==_Exmh_1572491818_4623P--
