Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 851697BC40A
	for <lists+linux-erofs@lfdr.de>; Sat,  7 Oct 2023 04:00:40 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=permerror header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha1 header.s=google header.b=QxEBTlWk;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4S2T5y2wfGz3vXD
	for <lists+linux-erofs@lfdr.de>; Sat,  7 Oct 2023 13:00:38 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=QxEBTlWk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=2a00:1450:4864:20::135; helo=mail-lf1-x135.google.com; envelope-from=torvalds@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RxxDh1nWmz3cNN
	for <linux-erofs@lists.ozlabs.org>; Sat, 30 Sep 2023 02:50:42 +1000 (AEST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-503056c8195so23223425e87.1
        for <linux-erofs@lists.ozlabs.org>; Fri, 29 Sep 2023 09:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1696006238; x=1696611038; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1jnYTA/sVS+Z8Orhdi2AQdhdCY0rlD66I6Sde9ZBPos=;
        b=QxEBTlWkabByNAvag4PSNcRoRT2fgu04XKkWBGxezJfkeSjRNOsQiRT3YdY9QXoVNH
         343KbITcFKQGJnX1B9JLgi3usA0yoIHKLzhNcLDQ1oZrJbHJuPKmGq46FT4R4KbaQkdP
         WmxST3ogT16KyC0zJpgOwBjFRjWvIK80VrxmA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696006238; x=1696611038;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1jnYTA/sVS+Z8Orhdi2AQdhdCY0rlD66I6Sde9ZBPos=;
        b=twboTY3J1hkKJaE4P+/SYaVLZl+4rufAmudztwRuPsFWgrAYugM2BgvRYink+/7sKl
         NgLZAG2DtmSRlgLHCyPVu87z1I9bw1E0EneNUKLwMnPgi/r/JzF7mpKs9/6gNxspD2et
         A9KIA21HvFq10Nctxgdb3mleLmTWPIlJhUX5EM6ZKe59SCWO4V3X7aommxlZKRy6IO5W
         NVYX24NezrMkR2gups3c6+XYgl+r1eBUlvuo2sDksn9kmP3MOu70C5Gmw98Kx9G/Je2T
         EPPs6mNxcS9+L42VIq+Hgv0SlZ3NvUO2WnEZw+TE9zvG2RXCpHjIcOk39lv2o1/Qndkw
         7NTA==
X-Gm-Message-State: AOJu0YwRZ0xzALrRXtKE5fWAN/vHpEHSxmiF8oTqdQyPIDoRoq26IHmX
	OjfY2Bp/6pzOlAny2F6pLUs5xqrf5tcsfAqmLVFpzfT6h0c=
X-Google-Smtp-Source: AGHT+IG+WrnEKPYXtc8TU7MaxZWtkqH5n1L8gPPZts0DE6Pa8iHkX2cCUTgv6aXJLryARYLp3gmdUA==
X-Received: by 2002:a05:6512:448:b0:4e0:a426:6ddc with SMTP id y8-20020a056512044800b004e0a4266ddcmr3899655lfk.0.1696006237945;
        Fri, 29 Sep 2023 09:50:37 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id f8-20020ac25328000000b004fe37339f8esm3584395lfh.149.2023.09.29.09.50.37
        for <linux-erofs@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Sep 2023 09:50:37 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5041d6d8b10so23202481e87.2
        for <linux-erofs@lists.ozlabs.org>; Fri, 29 Sep 2023 09:50:37 -0700 (PDT)
X-Received: by 2002:a17:907:2722:b0:9a1:cdf1:ba3 with SMTP id
 d2-20020a170907272200b009a1cdf10ba3mr4628345ejl.27.1696004552316; Fri, 29 Sep
 2023 09:22:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230928110554.34758-1-jlayton@kernel.org> <20230928110554.34758-2-jlayton@kernel.org>
 <6020d6e7-b187-4abb-bf38-dc09d8bd0f6d@app.fastmail.com> <af047e4a1c6947c59d4a13d4ae221c784a5386b4.camel@kernel.org>
 <20230928171943.GK11439@frogsfrogsfrogs> <6a6f37d16b55a3003af3f3dbb7778a367f68cd8d.camel@kernel.org>
 <20230928212656.GC189345@mit.edu> <CAHk-=wjTynK9BdGbi+8eShU77nkPvipFwRxEd1TSBrw2+LiuDg@mail.gmail.com>
 <CAOQ4uxg5ctY9yCjLOjN1nETAcEuNb2UERnYuDv7PoErdxX=WUw@mail.gmail.com>
In-Reply-To: <CAOQ4uxg5ctY9yCjLOjN1nETAcEuNb2UERnYuDv7PoErdxX=WUw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 29 Sep 2023 09:22:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjTZ=6QkE_eksL+kzywj2cA_kiY-ydZKoz-+kBQwtNWwQ@mail.gmail.com>
Message-ID: <CAHk-=wjTZ=6QkE_eksL+kzywj2cA_kiY-ydZKoz-+kBQwtNWwQ@mail.gmail.com>
Subject: Re: [PATCH 86/87] fs: switch timespec64 fields in inode to discrete integers
To: Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sat, 07 Oct 2023 12:58:50 +1100
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
Cc: Latchesar Ionkov <lucho@ionkov.net>, Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, "Rafael J . Wysocki" <rafael@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, Anders Larsen <al@alarsen.net>, Carlos Llamas <cmllamas@google.com>, Andrii Nakryiko <andrii@kernel.org>, Mattia Dongili <malattia@linux.it>, Hugh Dickins <hughd@google.com>, Yonghong Song <yonghong.song@linux.dev>, Alexander Gordeev <agordeev@linux.ibm.com>, Christoph Hellwig <hch@lst.de>, Mike Marshall <hubcap@omnibond.com>, Paulo Alcantara <pc@manguebit.com>, linux-xfs@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, James Morris <jmorris@namei.org>, Christophe Leroy <christophe.leroy@csgroup.eu>, Christoph Hellwig <hch@infradead.org>, Christian Borntraeger <borntraeger@linux.ibm.com>, devel@lists.orangefs.org, Shyam Prasad N <sprasad@microsoft.com>, linux-um@lists.infradead.org, Nicholas Piggin <npiggin@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Eric Van Hensbergen <ericvh@kernel.
 org>, Suren Baghdasaryan <surenb@google.com>, Trond Myklebust <trond.myklebust@hammerspace.com>, Anton Altaparmakov <anton@tuxera.com>, Christian Brauner <brauner@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Stephen Smalley <stephen.smalley.work@gmail.com>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Ronnie Sahlberg <lsahlber@redhat.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, Chuck Lever <chuck.lever@oracle.com>, Sven Schnelle <svens@linux.ibm.com>, Jiri Olsa <jolsa@kernel.org>, Jan Kara <jack@suse.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-trace-kernel@vger.kernel.org, Dave Kleikamp <shaggy@kernel.org>, samba-technical@lists.samba.org, linux-mm@kvack.org, Joel Fernandes <joel@joelfernandes.org>, Eric Dumazet <edumazet@google.com>, Stanislav Fomichev <sdf@google.com>, codalist@telemann.coda.cs.cmu.edu, linux-s390@vger.kernel.org, linux-nilfs@vger.ker
 nel.org, Paul Moore <paul@paul-moore.com>, Leon Romanovsky <leon@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>, Iurii Zaikin <yzaikin@google.com>, Namjae Jeon <linkinjeon@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Todd Kjos <tkjos@android.com>, Vasily Gorbik <gor@linux.ibm.com>, selinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, reiserfs-devel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>, John Johansen <john.johansen@canonical.com>, Jaegeuk Kim <jaegeuk@kernel.org>, Martijn Coenen <maco@android.com>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Hao Luo <haoluo@google.com>, Tony Luck <tony.luck@intel.com>, Theodore Ts'o <tytso@mit.edu>, Nicolas Pitre <nico@fluxnic.net>, linux-ntfs-dev@lists.sourceforge.net, Muchun Song <muchun.song@linux.dev>, linux-f2fs-devel@lists.sourceforge.net, "Guilherme G. Piccoli" <gpiccoli@igalia.com>, gfs2@lists.linux.dev, "Eric W. Biederman" <ebiederm@xmission.com>, Anna Schumaker <anna@
 kernel.org>, Brad Warrum <bwarrum@linux.ibm.com>, Mike Kravetz <mike.kravetz@oracle.com>, linux-efi@vger.kernel.org, Martin Brandenburg <martin@omnibond.com>, ocfs2-devel@lists.linux.dev, Alexei Starovoitov <ast@kernel.org>, Yue Hu <huyue2@gl0jj8bn.sched.sma.tdnsstic1.cn>, Chris Mason <clm@fb.com>, linux-mtd@lists.infradead.org, linux-hardening@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>, Jiri Slaby <jirislaby@kernel.org>, linux-afs@lists.infradead.org, Ian Kent <raven@themaw.net>, Naohiro Aota <naohiro.aota@wdc.com>, Daniel Borkmann <daniel@iogearbox.net>, Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, linux-rdma@vger.kernel.org, coda@cs.cmu.edu, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, Ilya Dryomov <idryomov@gmail.com>, Paolo Abeni <pabeni@redhat.com>, "Serge E. Hallyn" <serge@hallyn.com>, Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>, autofs@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Mark Gross <mark
 gross@kernel.org>, Damien Le Moal <dlemoal@kernel.org>, Eric Paris <eparis@parisplace.org>, ceph-devel@vger.kernel.org, Jan Harkes <jaharkes@cs.cmu.edu>, linux-nfs@vger.kernel.org, linux-ext4@vger.kernel.org, Olga Kornievskaia <kolga@netapp.com>, Song Liu <song@kernel.org>, Jeff Layton <jlayton@kernel.org>, Steve French <sfrench@samba.org>, Jeremy Kerr <jk@ozlabs.org>, Netdev <netdev@vger.kernel.org>, Bob Peterson <rpeterso@redhat.com>, linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org, ntfs3@lists.linux.dev, linux-erofs@lists.ozlabs.org, "David S . Miller" <davem@davemloft.net>, Chandan Babu R <chandan.babu@oracle.com>, jfs-discussion@lists.sourceforge.net, Jan Kara <jack@suse.cz>, Neil Brown <neilb@suse.de>, Dominique Martinet <asmadeus@codewreck.org>, Christian Schoenebeck <linux_oss@crudebyte.com>, Bob Copeland <me@bobcopeland.com>, KP Singh <kpsingh@kernel.org>, linux-unionfs@vger.kernel.org, David Howells <dhowells@redhat.com>, Joseph Qi <joseph.qi@linux.alibaba.com>, Andreas
  Dilger <adilger.kernel@dilger.ca>, Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>, Ard Biesheuvel <ardb@kernel.org>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Andreas Gruenbacher <agruenba@redhat.com>, Richard Weinberger <richard@nod.at>, Mark Fasheh <mark@fasheh.com>, Dai Ngo <Dai.Ngo@oracle.com>, Jason Gunthorpe <jgg@ziepe.ca>, linux-serial@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, Salah Triki <salah.triki@gmail.com>, platform-driver-x86@vger.kernel.org, Evgeniy Dushistov <dushistov@mail.ru>, linux-cifs@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, apparmor@lists.ubuntu.com, Josef Bacik <josef@toxicpanda.com>, Tom Talpey <tom@talpey.com>, Hans de Goede <hdegoede@redhat.com>, "Tigran A. Aivazian" <aivazian.tigran@gmail.com>, David Sterba <dsterba@suse.com>, Xiubo Li <xiubli@redhat.com>, Ryusuke Konishi <konishi.ryusuke@gmail.com>, Johannes Thumshirn <jth@kernel.org>, Ritu Agarwal <rituagar@linux.ibm.com>, Luis de Bethencourt <luisbg@kernel.org>, Martin Ka
 Fai Lau <martin.lau@linux.dev>, v9fs@lists.linux.dev, David Sterba <dsterba@suse.cz>, linux-security-module@vger.kernel.org, Phillip Lougher <phillip@squashfs.org.uk>, Johannes Berg <johannes@sipsolutions.net>, Sungjong Seo <sj1557.seo@samsung.com>, David Woodhouse <dwmw2@infradead.org>, linux-karma-devel@lists.sourceforge.net, linux-btrfs@vger.kernel.org, Joel Becker <jlbec@evilplan.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, 28 Sept 2023 at 20:50, Amir Goldstein <amir73il@gmail.com> wrote:
>
> OTOH, it is perfectly fine if the vfs wants to stop providing sub 100ns
> services to filesystems. It's just going to be the fs problem and the
> preserved pre-historic/fine-grained time on existing files would only
> need to be provided in getattr(). It does not need to be in __i_mtime.

Hmm. That sounds technically sane, but for one thing: if the aim is to try to do

 (a) atomic timestamp access

 (b) shrink the inode

then having the filesystem maintain its own timestamp for fine-grained
data will break both of those goals.

Yes, we'd make 'struct inode' smaller if we pack the times into one
64-bit entity, but if btrfs responds by adding mtime fields to "struct
btrfs_inode", we lost the size advantage and only made things worse.

And if ->getattr() then reads those fields without locking (and we
definitely don't want locking in that path), then we lost the
atomicity thing too.

So no. A "but the filesystem can maintain finer granularity" model is
not acceptable, I think.

If we do require nanoseconds for compatibility, what we could possibly
do is say "we guarantee nanosecond values for *legacy* dates", and say
that future dates use 100ns resolution. We'd define "legacy dates" to
be the traditional 32-bit signed time_t.

So with a 64-bit fstime_t, we'd have the "legacy format":

 - top 32 bits are seconds, bottom 32 bits are ns

which gives us that ns format.

Then, because only 30 bits are needed for nanosecond resolution, we
use the top two bits of that ns field as flags. '00' means that legacy
format, and '01' would mean "we're not doing nanosecond resolution,
we're doing 64ns resolution, and the low 6 bits of the ns field are
actually bits 32-37 of the seconds field".

That still gives us some extensibility (unless the multi-grain code
still wants to use the other top bit), and it gives us 40 bits of
seconds, which is quite a lot.

And all the conversion functions will be simple bit field
manipulations, so there are no expensive ops here.

Anyway, I agree with the "let's introduce the accessor functions
first, we can do the 'pack into one word' decisions later".

                Linus
