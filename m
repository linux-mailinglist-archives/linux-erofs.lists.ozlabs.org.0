Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A022EF26A
	for <lists+linux-erofs@lfdr.de>; Tue,  5 Nov 2019 02:03:52 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 476WdJ6lF4zDqV8
	for <lists+linux-erofs@lfdr.de>; Tue,  5 Nov 2019 12:03:48 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=vt.edu
 (client-ip=2607:b400:92:8400:0:33:fb76:806e; helo=omr2.cc.vt.edu;
 envelope-from=valdis@vt.edu; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=vt.edu
Received: from omr2.cc.vt.edu (omr2.cc.ipv6.vt.edu
 [IPv6:2607:b400:92:8400:0:33:fb76:806e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 476WRJ4k05zF3mR
 for <linux-erofs@lists.ozlabs.org>; Tue,  5 Nov 2019 11:55:06 +1100 (AEDT)
Received: from mr5.cc.vt.edu (junk.cc.ipv6.vt.edu
 [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
 by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id xA50swvo001279
 for <linux-erofs@lists.ozlabs.org>; Mon, 4 Nov 2019 19:54:58 -0500
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mr5.cc.vt.edu (8.14.7/8.14.7) with ESMTP id xA50sr2E026862
 for <linux-erofs@lists.ozlabs.org>; Mon, 4 Nov 2019 19:54:58 -0500
Received: by mail-qk1-f198.google.com with SMTP id z64so19783457qkc.15
 for <linux-erofs@lists.ozlabs.org>; Mon, 04 Nov 2019 16:54:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
 :mime-version:content-transfer-encoding:date:message-id;
 bh=f2xKui4jCV1oC4mz8c3C4oOoH3JHAT+nc4LWmlpw1MY=;
 b=Xeso2eVcbzWNwgt0N/iC56V3v20YA1Kot6RkFLSAF1xLphm5YuS1x/jeB/XtFGfkol
 yxIQ4vjQx6wm2mRFCT6FsxKmGVxXM/V9I7IeQQutEbi2XS6QUjo/BboQat/5SZ2I87YV
 zBfvEqtgB+R17N+6r4my5Z2h3OZ82B0z4ItBER0vphizH8iimjqs4i2N1LBqhvxWF9JR
 WhLs1T8eUo7IVM/XMjdJkgCFVuVwusi0H7ZnBgB6UpfED9iRfbiE71Gib70+r5BUv6Lk
 ZjDpwmKju+X2YvsuqT+h7PRseOslHy5EYWtTdHEYXxV9XHl2fTr76i3yvnCVeZDEvriq
 MVEw==
X-Gm-Message-State: APjAAAWPLT9BpaQBtfGC4aNtI/I53OK8Mcnb6vWGZtIruUYQ0dSwMNFh
 AaGWQgd9kcSHRoefQoKnBx2UciJreHW/XijnyRKhkSB5ezQ9wZrAlElOqvRUSd1IEonfx1pjr88
 Yiv02CID5h37SDPpFp8SNkbJg4STweeVwyD4=
X-Received: by 2002:a37:a7c6:: with SMTP id
 q189mr18281730qke.469.1572915293242; 
 Mon, 04 Nov 2019 16:54:53 -0800 (PST)
X-Google-Smtp-Source: APXvYqyrX9VI+c8WOT6M7oWIp4pyDtJDt5bkVm4lsJ+Pto7z9dB2TfD2fE/LTt42veVX3e6Xy+Pgiw==
X-Received: by 2002:a37:a7c6:: with SMTP id
 q189mr18281700qke.469.1572915292941; 
 Mon, 04 Nov 2019 16:54:52 -0800 (PST)
Received: from turing-police ([2601:5c0:c001:c9e1::359])
 by smtp.gmail.com with ESMTPSA id q17sm14389538qtq.58.2019.11.04.16.54.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2019 16:54:51 -0800 (PST)
From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks"
 <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 10/10] errno.h: Provide EFSCORRUPTED for everybody
In-Reply-To: <20191105003306.GA22791@infradead.org>
References: <20191104014510.102356-1-Valdis.Kletnieks@vt.edu>
 <20191104014510.102356-11-Valdis.Kletnieks@vt.edu>
 <20191105003306.GA22791@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1572915290_14215P";
 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 04 Nov 2019 19:54:50 -0500
Message-ID: <183873.1572915290@turing-police>
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
 "Darrick J . Wong" <darrick.wong@oracle.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 Andreas Dilger <adilger.kernel@dilger.ca>, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>,
 Gao Xiang <xiang@kernel.org>, linux-ext4@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, Jan Kara <jack@suse.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

--==_Exmh_1572915290_14215P
Content-Type: text/plain; charset=us-ascii

On Mon, 04 Nov 2019 16:33:06 -0800, Christoph Hellwig said:
> On Sun, Nov 03, 2019 at 08:45:06PM -0500, Valdis Kletnieks wrote:
> > There's currently 6 filesystems that have the same #define. Move it
> > into errno.h so it's defined in just one place.
>
> And 4 out of 6 also define EFSBADCRC, so please lift that as well.

Will do so in a separate patch shortly.


--==_Exmh_1572915290_14215P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXcDIWQdmEQWDXROgAQLCeRAAuaK/m71WLPW3IHgW8r5L9+3+x+9uaM3q
1xF50a4RrgesQOcgCjLxlCHEj7RzckAn1cAh8KCEfckr5crfRHSqOkSop9jE5A4X
BG71oLoyeYpSB1euVq/wxyUk7pk23uB3YfoPY3GD/zNUUxinrXRcc5AIBake1wfX
1tuIjSwBgO6HILMF7PKK+ETFDGBDXKUfzep/1ooWpKYzqbMyLkrd5iYQy5a9Fy3r
wbIOv0vg1dyMa3rcpFO6XKieD3yZkPO42lYIu6Te1wFnykmkCpgkMaOGP9/HWIPP
vkm2vDMS7gbWWYgbs2k0IsKKKTjhO+sapW3QbYNnxYEBgwYaIfaKhJGpqWQ6qoqR
Lr2OQWp/xv+g6bKr23kdXM+Iz8i6m38gl0LPwCa0K5I1WHSbelWoRniJ41jRcVeW
GPr6Hu+CZxD0nYigQV7AXFnlk2E8X525kiTffPz+KtMpUS8VzaSCMkc7GQMMdPbI
bZD328DLengZVicm271CUIiVhHvRD8tzw/6Z3UyM9lxCCjtkpFQI+ERMPATGTT/D
hwZmJzEj5esJYzs+PyEDt/d7pA0kzpW0XObEjX7apDgMWXWk7WmczJPPJENH6lVw
ULNeg4s+MlG6qt3eiC8+DPM6MxQtyen9NaE90UtCHunhRxt6tZSzbGSuHRYVWCdQ
9OgZEz7s3DI=
=W6JA
-----END PGP SIGNATURE-----

--==_Exmh_1572915290_14215P--
