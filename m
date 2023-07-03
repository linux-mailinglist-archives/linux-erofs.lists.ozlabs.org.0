Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BED474543E
	for <lists+linux-erofs@lfdr.de>; Mon,  3 Jul 2023 05:42:44 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=3Xi9NJjk;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QvWw16LQjz30g1
	for <lists+linux-erofs@lfdr.de>; Mon,  3 Jul 2023 13:42:41 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=mcgrof@infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Qt8m93Lx5z2ys4;
	Sat,  1 Jul 2023 08:16:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mmrCw93FsSgGVqkQGx3tY+c3DxJ3ErMGqt6cuZmQDk4=; b=3Xi9NJjkd4QPELIEMLqHm1+oJy
	QNIOVPA8HW3kXP6XuZluim3h/1Z/sfwrG9QOzNRHgYq+vOXcblPYVWq7qnircmbeiJPJDVgOjWyzo
	LbnhyHqo5AegY+fER/tKQShp8dh+Z/+/bv4xI3KoQiSpmxUAYDgP6p5vAe2pi77qFUU0ycsQEmV7V
	4gCVdOf3P+PueFWMrnvROKMoMz+u7SsILxSnayKbZrj37v0X+NhKaX7iej/SD3IFAsLN2XayGDdUC
	G3y/vRbujnR04W/Op5jRENlRX4f86+/5+pwYqxdiQMmhYNN5AwTPrNqa/XDugttEtOweLL0X0YqO/
	pQ84xrwQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qFML8-004eW8-2f;
	Fri, 30 Jun 2023 22:11:42 +0000
Date: Fri, 30 Jun 2023 15:11:42 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Julia Lawall <julia.lawall@inria.fr>, Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH 00/79] fs: new accessors for inode->i_ctime
Message-ID: <ZJ9THiUlOUmm0xpD@bombadil.infradead.org>
References: <20230621144507.55591-1-jlayton@kernel.org>
 <20230621152141.5961cf5f@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621152141.5961cf5f@gandalf.local.home>
X-Mailman-Approved-At: Mon, 03 Jul 2023 13:42:33 +1000
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
Cc: Latchesar Ionkov <lucho@ionkov.net>, "Rafael J. Wysocki" <rafael@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, Anders Larsen <al@alarsen.net>, Carlos Llamas <cmllamas@google.com>, Hugh Dickins <hughd@google.com>, John Johansen <john.johansen@canonical.com>, Seth Forshee <sforshee@digitalocean.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Christoph Hellwig <hch@lst.de>, Mike Marshall <hubcap@omnibond.com>, Paulo Alcantara <pc@manguebit.com>, linux-xfs@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>, Michael Ellerman <mpe@ellerman.id.au>, John Keeping <john@keeping.me.uk>, Zhang Yi <yi.zhang@huawei.com>, James Morris <jmorris@namei.org>, Christophe Leroy <christophe.leroy@csgroup.eu>, Tyler Hicks <code@tyhicks.com>, Alan Stern <stern@rowland.harvard.edu>, Christian Borntraeger <borntraeger@linux.ibm.com>, devel@lists.orangefs.org, Shyam Prasad N <sprasad@microsoft.com>, Jan Harkes <jaharkes@cs.cmu.edu>, linux-um@lists.infradead.org, Nicholas Piggin <npiggin@gmail.co
 m>, Alexander Viro <viro@zeniv.linux.org.uk>, Eric Van Hensbergen <ericvh@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Trond Myklebust <trond.myklebust@hammerspace.com>, Anton Altaparmakov <anton@tuxera.com>, Christian Brauner <brauner@kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Stephen Smalley <stephen.smalley.work@gmail.com>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Ronnie Sahlberg <lsahlber@redhat.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>, Chuck Lever <chuck.lever@oracle.com>, Sven Schnelle <svens@linux.ibm.com>, Jiri Olsa <jolsa@kernel.org>, Jan Kara <jack@suse.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-trace-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, Dave Kleikamp <shaggy@kernel.org>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, samba-technical@lists.samba.org, Mimi 
 Zohar <zohar@linux.ibm.com>, linux-mm@kvack.org, Joel Fernandes <joel@joelfernandes.org>, Eric Dumazet <edumazet@google.com>, Stanislav Fomichev <sdf@google.com>, Andrzej Pietrasiewicz <andrzej.p@collabora.com>, Hangyu Hua <hbh25y@gmail.com>, linux-s390@vger.kernel.org, linux-nilfs@vger.kernel.org, Paul Moore <paul@paul-moore.com>, Leon Romanovsky <leon@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Minghao Chi <chi.minghao@zte.com.cn>, codalist@coda.cs.cmu.edu, selinux@vger.kernel.org, ZhangPeng <zhangpeng362@huawei.com>, Udipto Goswami <quic_ugoswami@quicinc.com>, Yonghong Song <yhs@fb.com>, Iurii Zaikin <yzaikin@google.com>, Namjae Jeon <linkinjeon@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, ecryptfs@vger.kernel.org, Todd Kjos <tkjos@android.com>, Vasily Gorbik <gor@linux.ibm.com>, Yu Zhe <yuzhe@nfschina.com>, linuxppc-dev@lists.ozlabs.org, reiserfs-devel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>, Yue Hu <huyue2@coo
 lpad.com>, Jaegeuk Kim <jaegeuk@kernel.org>, Aditya Garg <gargaditya08@live.com>, Martijn Coenen <maco@android.com>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Hao Luo <haoluo@google.com>, Tony Luck <tony.luck@intel.com>, Theodore Ts'o <tytso@mit.edu>, Nicolas Pitre <nico@fluxnic.net>, linux-ntfs-dev@lists.sourceforge.net, Muchun Song <muchun.song@linux.dev>, Roberto Sassu <roberto.sassu@huawei.com>, linux-f2fs-devel@lists.sourceforge.net, "Guilherme G. Piccoli" <gpiccoli@igalia.com>, Jozef Martiniak <jomajm@gmail.com>, Eric Biederman <ebiederm@xmission.com>, Anna Schumaker <anna@kernel.org>, xu xin <cgel.zte@gmail.com>, Brad Warrum <bwarrum@linux.ibm.com>, Mike Kravetz <mike.kravetz@oracle.com>, Jingyu Wang <jingyuwang_vip@163.com>, linux-efi@vger.kernel.org, Dan Carpenter <error27@gmail.com>, Martin Brandenburg <martin@omnibond.com>, Tom Rix <trix@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Chris Mason <clm@fb.com>, linux-mtd@lists.infradead.org, "Matthew Wilcox \(Oracle\
 )" <willy@infradead.org>, Marc Dionne <marc.dionne@auristor.com>, linux-afs@lists.infradead.org, Ian Kent <raven@themaw.net>, Naohiro Aota <naohiro.aota@wdc.com>, Daniel Borkmann <daniel@iogearbox.net>, Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, linux-rdma@vger.kernel.org, Linyu Yuan <quic_linyyuan@quicinc.com>, coda@cs.cmu.edu, Viacheslav Dubeyko <slava@dubeyko.com>, Ilya Dryomov <idryomov@gmail.com>, Paolo Abeni <pabeni@redhat.com>, Alexey Dobriyan <adobriyan@gmail.com>, "Serge E. Hallyn" <serge@hallyn.com>, Zhihao Cheng <chengzhihao1@huawei.com>, Jens Axboe <axboe@kernel.dk>, Zeng Jingxiang <linuszeng@tencent.com>, Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>, autofs@vger.kernel.org, Yifei Liu <yifeliu@cs.stonybrook.edu>, Damien Le Moal <dlemoal@kernel.org>, Eric Paris <eparis@parisplace.org>, ceph-devel@vger.kernel.org, Jiangshan Yi <yijiangshan@kylinos.cn>, David Howells <dhowells@redhat.com>, linux-nfs@vger.kernel.org, linux-ext4@vger.ker
 nel.org, Song Liu <song@kernel.org>, Jeff Layton <jlayton@kernel.org>, Steve French <sfrench@samba.org>, Jeremy Kerr <jk@ozlabs.org>, netdev@vger.kernel.org, Bob Peterson <rpeterso@redhat.com>, linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org, ntfs3@lists.linux.dev, linux-erofs@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>, ocfs2-devel@oss.oracle.com, jfs-discussion@lists.sourceforge.net, Dominique Martinet <asmadeus@codewreck.org>, Christian Schoenebeck <linux_oss@crudebyte.com>, Bob Copeland <me@bobcopeland.com>, KP Singh <kpsingh@kernel.org>, Oleg Kanatov <okanatov@gmail.com>, Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Joseph Qi <joseph.qi@linux.alibaba.com>, Yuta Hayama <hayama@lineo.co.jp>, Andreas Dilger <adilger.kernel@dilger.ca>, Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>, Zhengchao Shao <shaozhengchao@huawei.com>, Chen Zhongjin <chenzhongjin@huawei.com>, Ard Biesheuvel <ardb@kernel.org>, Anton Ivanov <anton.ivanov@cambridgegreys.com
 >, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Andreas Gruenbacher <agruenba@redhat.com>, Richard Weinberger <richard@nod.at>, Mark Fasheh <mark@fasheh.com>, Stefan Roesch <shr@devkernel.io>, cluster-devel@redhat.com, Jason Gunthorpe <jgg@ziepe.ca>, Jakub Kicinski <kuba@kernel.org>, Rik van Riel <riel@surriel.com>, Salah Triki <salah.triki@gmail.com>, Evgeniy Dushistov <dushistov@mail.ru>, linux-cifs@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, apparmor@lists.ubuntu.com, Josef Bacik <josef@toxicpanda.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, Tom Talpey <tom@talpey.com>, Hans de Goede <hdegoede@redhat.com>, "Tigran A. Aivazian" <aivazian.tigran@gmail.com>, Dave Chinner <dchinner@redhat.com>, David Sterba <dsterba@suse.com>, Xiubo Li <xiubli@redhat.com>, Ryusuke Konishi <konishi.ryusuke@gmail.com>, Juergen Gross <jgross@suse.com>, Johannes Thumshirn <jth@kernel.org>, Ritu Agarwal <rituagar@linux.ibm.com>, Luis de Bethencourt <luisbg@kernel.org>, Mart
 in KaFai Lau <martin.lau@linux.dev>, v9fs@lists.linux.dev, "Fabio M. De Francesco" <fmdefrancesco@gmail.com>, linux-unionfs@vger.kernel.org, Ruihan Li <lrh2000@pku.edu.cn>, linux-security-module@vger.kernel.org, Erez Zadok <ezk@cs.stonybrook.edu>, "Dr. David Alan Gilbert" <linux@treblig.org>, Johannes Weiner <hannes@cmpxchg.org>, Phillip Lougher <phillip@squashfs.org.uk>, Johannes Berg <johannes@sipsolutions.net>, Sungjong Seo <sj1557.seo@samsung.com>, David Woodhouse <dwmw2@infradead.org>, linux-karma-devel@lists.sourceforge.net, linux-btrfs@vger.kernel.org, Joel Becker <jlbec@evilplan.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Jun 21, 2023 at 03:21:41PM -0400, Steven Rostedt wrote:
> On Wed, 21 Jun 2023 10:45:05 -0400
> Jeff Layton <jlayton@kernel.org> wrote:
> 
> > Most of this conversion was done via coccinelle, with a few of the more
> > non-standard accesses done by hand. There should be no behavioral
> > changes with this set. That will come later, as we convert individual
> > filesystems to use multigrain timestamps.
> 
> BTW, Linus has suggested to me that whenever a conccinelle script is used,
> it should be included in the change log.

Sometimes people like the coccinelle included in the commit, sometimes
people don't [0], it really ends up being up to a subjective maintainer
preference. A compromise could be to use git notes as these are
optional, however if we want to go down that path we should try to make
a general consensus on it so we can send a consistent message.

[0] https://lore.kernel.org/all/20230512073100.GC32559@twin.jikos.cz/

  Luis
