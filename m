Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 51499A2C3D
	for <lists+linux-erofs@lfdr.de>; Fri, 30 Aug 2019 03:25:06 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46KMGl5bZLzDr7p
	for <lists+linux-erofs@lfdr.de>; Fri, 30 Aug 2019 11:25:03 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=omnibond.com
 (client-ip=2607:f8b0:4864:20::c43; helo=mail-yw1-xc43.google.com;
 envelope-from=hubcap@omnibond.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=omnibond.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=omnibond-com.20150623.gappssmtp.com
 header.i=@omnibond-com.20150623.gappssmtp.com header.b="rsF3TnYv"; 
 dkim-atps=neutral
Received: from mail-yw1-xc43.google.com (mail-yw1-xc43.google.com
 [IPv6:2607:f8b0:4864:20::c43])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46KMGf4WmNzDr2y
 for <linux-erofs@lists.ozlabs.org>; Fri, 30 Aug 2019 11:24:53 +1000 (AEST)
Received: by mail-yw1-xc43.google.com with SMTP id m11so1848157ywh.3
 for <linux-erofs@lists.ozlabs.org>; Thu, 29 Aug 2019 18:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=omnibond-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=4TfZVE6zvYYuoOuB/Rxqa+Mlm3vtxZPY12krCFPSTtI=;
 b=rsF3TnYvnJjkhMrqd8jgi2b1fWfnS720m/snkWNYBAl3jogwp2mEsqA8h0meBBMFCG
 mupgLKrOXopsTT3mx+lDcAZLHUPbfCw/vXrZaEIvlfIiq4H0dj/IKCul0NWP4fpGLsu4
 48Lini1zfDu9D/EL0CeWiI8kZAXrgg08x+hcJWXhpsmSN701z4+zSsQ5V2A/N+PZ/ko+
 cAveXQxi5GTfOnxm/M0L2QMcpa0QpEp0UoezlsX6vklrx1noOLsykTvVpPGdg1yASetm
 NGCTD4uF7gFM2G4DP0Fj0jWpPyOxMpJF0KkXFU1tGtaTorkpzYDBwzJA49OyfPjy95xt
 U/rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=4TfZVE6zvYYuoOuB/Rxqa+Mlm3vtxZPY12krCFPSTtI=;
 b=hNGq1R2OF46IX1O30cqE6yLPO/6zvFUlgoXQEVE8HNTrUtmHOXvZ8kxakpIu3qrSLy
 GG0m4NabXqmdTzR9SGJCVbUm5NPlwkAibHjzTaHCYOLAvRFgIGfJD3hnDJ/H3RXPg+4r
 jU3JkT//9ElQd6I86J3/q2DzI6mO2BFbmQvJK0g1A9Ud6WgVbgv2QbhbzDLQGc1nu+CX
 stniF1KdlEtRo5H+GnMASH4vUW650vy/ju2pkJov0JMejg77DjH2E3PLxNbEBdyLZUdq
 ZIuDM8pxvOluOOvkTm7wvDM3qNjOAjlzQR9qFtK3U+SsY93sJkHupn1bEvyTYvLcSSsM
 RYcw==
X-Gm-Message-State: APjAAAWBkxTqMsv/mZ8UEZX+a2fkkX/0Sjy+bUzMQogAmeuhv2tt4mkR
 p8gaywQQVo+FtZVm0lZQXbfP1ZvN/NxVQ/eHFdv9eg==
X-Google-Smtp-Source: APXvYqwS/gBw6GYqWJhwCNBmHR6+W2ONQRTVjMY8ZXLyRIgVZbf1blJaiiDec2a/U/ArNO35ME5xZuocZ9cXu0GpPKQ=
X-Received: by 2002:a0d:d596:: with SMTP id x144mr9018446ywd.69.1567128290041; 
 Thu, 29 Aug 2019 18:24:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190827150544.151031-1-salyzyn@android.com>
 <20190828142423.GA1955@infradead.org>
 <5dd09a38-fffb-36f2-505b-be2ddf6bb750@android.com>
In-Reply-To: <5dd09a38-fffb-36f2-505b-be2ddf6bb750@android.com>
From: Mike Marshall <hubcap@omnibond.com>
Date: Thu, 29 Aug 2019 21:24:38 -0400
Message-ID: <CAOg9mSTCC4Z3RpEyppC50B+pnSBbV0sr-F7hbsM-B+z3c-AZVA@mail.gmail.com>
Subject: Re: [PATCH v8] Add flags option to get xattr method paired to
 __vfs_getxattr
To: Mark Salyzyn <salyzyn@android.com>
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
Cc: Latchesar Ionkov <lucho@ionkov.net>, Hugh Dickins <hughd@google.com>,
 James Morris <jmorris@namei.org>, Christoph Hellwig <hch@infradead.org>,
 devel@lists.orangefs.org, Eric Van Hensbergen <ericvh@gmail.com>,
 Joel Becker <jlbec@evilplan.org>, Anna Schumaker <anna.schumaker@netapp.com>,
 Trond Myklebust <trond.myklebust@hammerspace.com>,
 Mathieu Malaterre <malat@debian.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>, Jan Kara <jack@suse.com>,
 Casey Schaufler <casey@schaufler-ca.com>,
 Andrew Morton <akpm@linux-foundation.org>, Dave Kleikamp <shaggy@kernel.org>,
 linux-doc@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
 Mimi Zohar <zohar@linux.ibm.com>, linux-cifs@vger.kernel.org,
 Paul Moore <paul@paul-moore.com>, "Darrick J. Wong" <darrick.wong@oracle.com>,
 Eric Sandeen <sandeen@sandeen.net>, kernel-team@android.com,
 selinux@vger.kernel.org, Brian Foster <bfoster@redhat.com>,
 reiserfs-devel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
 Miklos Szeredi <miklos@szeredi.hu>, "Linux F2FS DEV,
 Mailing List" <linux-f2fs-devel@lists.sourceforge.net>,
 Benjamin Coddington <bcodding@redhat.com>, linux-integrity@vger.kernel.org,
 Martin Brandenburg <martin@omnibond.com>, Chris Mason <clm@fb.com>,
 linux-mtd <linux-mtd@lists.infradead.org>, linux-afs@lists.infradead.org,
 Jonathan Corbet <corbet@lwn.net>, Vyacheslav Dubeyko <slava@dubeyko.com>,
 Allison Henderson <allison.henderson@oracle.com>,
 Ilya Dryomov <idryomov@gmail.com>,
 Ext4 Developers List <linux-ext4@vger.kernel.org>,
 Stephen Smalley <sds@tycho.nsa.gov>, Serge Hallyn <serge@hallyn.com>,
 Eric Paris <eparis@parisplace.org>, ceph-devel <ceph-devel@vger.kernel.org>,
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
 linux-mm <linux-mm@kvack.org>, samba-technical@lists.samba.org,
 linux-xfs@vger.kernel.org, Bob Peterson <rpeterso@redhat.com>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-erofs@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>, ocfs2-devel@oss.oracle.com,
 jfs-discussion@lists.sourceforge.net, Jan Kara <jack@suse.cz>,
 Eric Biggers <ebiggers@google.com>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Adrian Hunter <adrian.hunter@intel.com>, David Howells <dhowells@redhat.com>,
 Joseph Qi <joseph.qi@linux.alibaba.com>,
 Andreas Dilger <adilger.kernel@dilger.ca>, devel@driverdev.osuosl.org,
 "J. Bruce Fields" <bfields@redhat.com>,
 Andreas Gruenbacher <agruenba@redhat.com>, Sage Weil <sage@redhat.com>,
 Richard Weinberger <richard@nod.at>, Mark Fasheh <mark@fasheh.com>,
 cluster-devel@redhat.com, Steve French <sfrench@samba.org>,
 V9FS Developers <v9fs-developer@lists.sourceforge.net>,
 Bharath Vedartham <linux.bhar@gmail.com>, Jann Horn <jannh@google.com>,
 ecryptfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
 Dave Chinner <dchinner@redhat.com>, David Sterba <dsterba@suse.com>,
 Artem Bityutskiy <dedekind1@gmail.com>, netdev@vger.kernel.org,
 linux-unionfs@vger.kernel.org, stable@vger.kernel.org,
 Tyler Hicks <tyhicks@canonical.com>, linux-security-module@vger.kernel.org,
 Phillip Lougher <phillip@squashfs.org.uk>,
 David Woodhouse <dwmw2@infradead.org>, linux-btrfs@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

I added this patch series on top of Linux 5.3-rc6 and ran xfstests
on orangefs with no regressions.

Acked-by: Mike Marshall <hubcap@omnibond.com>

-Mike

On Wed, Aug 28, 2019 at 10:40 AM Mark Salyzyn <salyzyn@android.com> wrote:
>
> On 8/28/19 7:24 AM, Christoph Hellwig wrote:
> > On Tue, Aug 27, 2019 at 08:05:15AM -0700, Mark Salyzyn wrote:
> >> Replace arguments for get and set xattr methods, and __vfs_getxattr
> >> and __vfs_setaxtr functions with a reference to the following now
> >> common argument structure:
> > Yikes.  That looks like a mess.  Why can't we pass a kernel-only
> > flag in the existing flags field for =E2=82=8B>set and add a flags fiel=
d
> > to ->get?  Passing methods by structure always tends to be a mess.
>
> This was a response to GregKH@ criticism, an earlier patch set just
> added a flag as you stated to get method, until complaints of an
> excessively long argument list and fragility to add or change more
> arguments.
>
> So many ways have been tried to skin this cat ... the risk was taken to
> please some, and we now have hundreds of stakeholders, when the first
> patch set was less than a dozen. A recipe for failure?
>
> -- Mark
>
